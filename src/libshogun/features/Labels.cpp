/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Written (W) 1999-2009 Soeren Sonnenburg
 * Written (W) 1999-2008 Gunnar Raetsch
 * Subset support written (W) 2011 Heiko Strathmann
 * Copyright (C) 1999-2009 Fraunhofer Institute FIRST and Max-Planck-Society
 */

#include "features/Labels.h"
#include "lib/common.h"
#include "lib/File.h"
#include "lib/io.h"
#include "lib/Mathematics.h"
#include "base/Parameter.h"

using namespace shogun;

CLabels::CLabels()
: CSGObject()
{
	init();
}

CLabels::CLabels(int32_t num_lab)
: CSGObject()
{
	init();

	labels=new float64_t[num_lab];
	for (int32_t i=0; i<num_lab; i++)
		labels[i]=0;

	num_labels=num_lab;
}

CLabels::CLabels(SGVector<float64_t> src)
: CSGObject()
{
	init();

	set_labels(src);
	m_num_classes=get_num_classes();
}

CLabels::CLabels(float64_t* p_labels, int32_t len)
: CSGObject()
{
	init();

	set_labels(p_labels, len);
	m_num_classes=get_num_classes();
}

void CLabels::set_to_one()
{
	ASSERT(labels);
	index_t subset_size=get_num_labels();
	for (int32_t i=0; i<subset_size; i++)
		labels[subset_idx_conversion(i)]=+1;
}

CLabels::CLabels(float64_t* in_confidences, int32_t in_num_labels,
				 int32_t in_num_classes)
: CSGObject()
{
	init();

	labels=new float64_t[in_num_labels];
	for (int32_t i=0; i<in_num_labels; i++)
		labels[i]=0;

	m_num_classes=in_num_classes;
	m_confidences=in_confidences;
	m_confidence_classes = in_num_classes;
	m_confidence_labels = in_num_labels;
	find_labels();
}

CLabels::CLabels(CFile* loader)
: CSGObject()
{
	init();
	load(loader);
}

CLabels::~CLabels()
{
	delete[] labels;
	delete[] m_confidences;
	delete m_subset;

	m_subset=NULL;
	num_labels=0;
	m_num_classes=0;
	labels=NULL;
	m_confidences=NULL;
	m_confidence_classes = 0;
	m_confidence_labels = 0;
}

void CLabels::init()
{
	m_parameters->add_vector(&labels, &num_labels, "labels",
							 "The labels.");
	m_parameters->add_matrix(&m_confidences, &m_confidence_classes,
							 &m_confidence_labels, "m_confidences",
							 "Confidence matrix.");

	m_parameters->add((CSGObject**)&m_subset, "subset", "Subset object");

	m_subset=NULL;
	labels=NULL;
	num_labels=0;
	m_confidences=NULL;
	m_confidence_classes=0;
	m_confidence_labels=0;
	m_num_classes=0;;
}

void CLabels::set_labels(SGVector<float64_t> v)
{
	if (m_subset)
		SG_ERROR("A subset is set, cannot set labels\n");

	delete[] labels;
	labels=v.vector;
	num_labels=v.vlen;
}

void CLabels::set_labels(float64_t* p_labels, int32_t len)
{
	if (m_subset)
		SG_ERROR("A subset is set, cannot set labels\n");

	ASSERT(len>0);

	num_labels=len;

	delete[] labels;
    labels=p_labels;
}

void CLabels::set_confidences(float64_t* in_confidences, int32_t in_num_labels, 
							  int32_t in_num_classes)
{
	if (m_subset)
		SG_ERROR("A subset is set, cannot set confidences\n");

	if (num_labels && (num_labels != in_num_labels))
	{
		SG_ERROR("Shape of confidence matrix mismatch (number of "
				"labels = %d does not match %d\n", num_labels, in_num_labels);
	}

	if (m_num_classes && (m_num_classes != in_num_classes))
	{
		SG_ERROR("Shape of confidence matrix mismatch (number of "
				"num_classes = %d does not match %d\n", m_num_classes, in_num_classes);
	}

	delete[] m_confidences;

	num_labels=in_num_labels;
	m_num_classes=in_num_classes;
	m_confidences=in_confidences;
	m_confidence_classes = in_num_classes;
	m_confidence_labels = in_num_labels;
	find_labels();
}

float64_t* CLabels::get_confidences(int32_t& out_num_labels, int32_t& out_num_classes)
{
	if (m_subset)
		SG_NOTIMPLEMENTED;

	out_num_labels=num_labels;
	out_num_classes=m_num_classes;
    
	if (!num_labels || !m_num_classes || !m_confidences)
		SG_ERROR("No labels / confidences set\n");

	float64_t* out_conf=new float64_t[num_labels*m_num_classes];
	memcpy(out_conf, m_confidences, num_labels*m_num_classes*sizeof(float64_t));
	return out_conf;
}

void CLabels::get_confidences(float64_t** dst, int32_t* out_num_labels, int32_t* out_num_classes)
{
	if (m_subset)
		SG_NOTIMPLEMENTED;

	ASSERT(dst && out_num_labels && out_num_classes);

	if (num_labels<=0 || m_num_classes<=0 || !m_confidences)
		SG_ERROR("No labels / confidences set\n");

	*dst=NULL;
	*out_num_labels=num_labels;
	*out_num_classes=m_num_classes;

	float64_t* out_conf= (float64_t*) SG_MALLOC((size_t) sizeof(float64_t)*num_labels*m_num_classes);
	memcpy(out_conf, m_confidences, num_labels*m_num_classes*sizeof(float64_t));
	*dst=out_conf;
}

float64_t* CLabels::get_sample_confidences(const int32_t& in_sample_index, 
										   int32_t& out_num_classes)
{
	if (m_subset)
		SG_NOTIMPLEMENTED;

	out_num_classes=m_num_classes;

	if (!(in_sample_index>=0 && in_sample_index<num_labels &&
				m_num_classes && m_confidences))
	{
		SG_ERROR("No labels / confidences set\n");
	}

	float64_t* out_conf=new float64_t[m_num_classes];
	for (int32_t n_class=0; n_class<m_num_classes; n_class++)
	{
		out_conf[n_class]=m_confidences[n_class+in_sample_index*m_num_classes];
	}
	return out_conf;
}

void CLabels::find_labels()
{
	ASSERT(m_confidences);
	ASSERT(labels);
	
	float64_t max_conf;
	int32_t index;
	int32_t subset_size=get_num_labels();
	for (int32_t n_samp=0; n_samp<subset_size; n_samp++)
	{
		int32_t real_n_samp=subset_idx_conversion(n_samp);
		max_conf=m_confidences[n_samp];
		labels[real_n_samp]=0;
		for (int32_t n_class=1; n_class<m_num_classes; n_class++)
		{
			index=real_n_samp+n_class*m_num_classes;
			if (m_confidences[index]>max_conf)
			{
				max_conf=m_confidences[index];
				labels[real_n_samp]=n_class;
			}
		}
	}
}

bool CLabels::is_two_class_labeling()
{
	ASSERT(labels);
	bool found_plus_one=false;
	bool found_minus_one=false;

	int32_t subset_size=get_num_labels();
	for (int32_t i=0; i<subset_size; i++)
	{
		int32_t real_i=subset_idx_conversion(i);
		if (labels[real_i]==+1.0)
			found_plus_one=true;
		else if (labels[real_i]==-1.0)
			found_minus_one=true;
		else
		{
			SG_ERROR("Not a two class labeling label[%d]=%f (only +1/-1 "
					"allowed)\n", i, labels[real_i]);
		}
	}

	if (!found_plus_one)
		SG_ERROR("Not a two class labeling - no positively labeled examples found\n");
	if (!found_minus_one)
		SG_ERROR("Not a two class labeling - no negatively labeled examples found\n");

	return true;
}

int32_t CLabels::get_num_classes()
{
	int32_t n=-1;
	int32_t* lab=get_int_labels(n);

	int32_t num_classes=0;
	for (int32_t i=0; i<n; i++)
		num_classes=CMath::max(num_classes,lab[i]);

	delete[] lab;

	return num_classes+1;
}

float64_t* CLabels::get_labels(int32_t &len)
{
	if (m_subset)
		SG_ERROR("get_labels() is not possible on subset\n");

	len=num_labels;
	return labels;
}


SGVector<float64_t> CLabels::get_labels()
{
	if (m_subset)
		SG_ERROR("get_labels() is not possible on subset");

	return SGVector<float64_t> (labels, num_labels);
}

int32_t* CLabels::get_int_labels(int32_t &len)
{
	len=get_num_labels();

	if (len>0)
	{
		int32_t* _labels=new int32_t[len] ;
		for (int32_t i=0; i<len; i++)
			_labels[i]= (int32_t) get_label(i) ;
		return _labels ;
	}
	else 
		return NULL;
}

void CLabels::set_int_labels(int32_t * mylabels, int32_t len)
{
	if (m_subset)
		SG_ERROR("set_int_labels() is not possible on subset");

	num_labels = len ;
	delete[] labels ;
	
	labels = new float64_t[num_labels] ;
	for (int32_t i=0; i<num_labels; i++)
		set_int_label(i, mylabels[i]) ;
}

void CLabels::load(CFile* loader)
{
	remove_subset();

	SG_SET_LOCALE_C;
	delete[] labels;
	delete[] m_confidences;
	m_confidences = NULL;
	m_confidence_classes = 0;
	m_confidence_labels = 0;
	num_labels=0;
	ASSERT(loader);
	loader->get_vector(labels, num_labels);
	m_num_classes=get_num_classes();
	SG_RESET_LOCALE;
}

void CLabels::save(CFile* writer)
{
	if (m_subset)
		SG_ERROR("save() is not possible on subset");

	SG_SET_LOCALE_C;
	ASSERT(writer);
	ASSERT(labels && labels>0);
	writer->set_vector(labels, num_labels);
	SG_RESET_LOCALE;
}

void CLabels::set_subset(CSubset* subset)
{
	SG_UNREF(m_subset);
	m_subset=subset;
	SG_REF(subset);
}

void CLabels::remove_subset()
{
	set_subset(NULL);
}
