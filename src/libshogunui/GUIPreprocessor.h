/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Written (W) 1999-2008 Soeren Sonnenburg
 * Written (W) 1999-2008 Gunnar Raetsch
 * Copyright (C) 1999-2008 Fraunhofer Institute FIRST and Max-Planck-Society
 */

#ifndef __GUIPREPROC_H__
#define __GUIPREPROC_H__

#include <shogun/lib/config.h>
#include <shogun/lib/List.h>
#include <shogun/base/SGObject.h>
#include <shogun/preprocessor/Preprocessor.h>

namespace shogun
{
class CSGInterface;

class CGUIPreprocessor : public CSGObject
{
	public:
		CGUIPreprocessor(CSGInterface* interface);
		~CGUIPreprocessor();

		/** create generic Preprocessor */
		CPreprocessor* create_generic(EPreprocessorType type);
		/** create preproc PruneVarSubMean */
		CPreprocessor* create_prunevarsubmean(bool divide_by_std=false);
		/** create preproc PCACUT */
		CPreprocessor* create_pcacut(bool do_whitening, float64_t threshold);

		/** add new preproc to list */
		bool add_preproc(CPreprocessor* preproc);
		/** delete last preproc in list */
		bool del_preproc();
		/** clean all preprocs from list */
		bool clean_preproc();

		/** attach preprocessor to TRAIN/TEST feature obj.
		 *  it will also preprocess train/test data
		 *  when a feature matrix is available
		 */
		bool attach_preproc(char* target, bool do_force=false);

		/** @return object name */
		inline virtual const char* get_name() const { return "GUIPreprocessor"; }

	protected:
		bool preprocess_features(CFeatures* trainfeat, CFeatures* testfeat, bool force);
		bool preproc_all_features(CFeatures* f, bool force);

		CList* preprocs;
		CSGInterface* ui;
};
}
#endif
