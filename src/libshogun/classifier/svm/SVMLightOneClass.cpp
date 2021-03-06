/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Written (W) 1999-2009 Soeren Sonnenburg
 * Copyright (C) 1999-2009 Fraunhofer Institute FIRST and Max-Planck-Society
 */

#include "lib/config.h"

#ifdef USE_SVMLIGHT

#include "lib/io.h"
#include "lib/lapack.h"
#include "lib/Signal.h"
#include "lib/Mathematics.h"
#include "classifier/svm/SVMLightOneClass.h"
#include "machine/KernelMachine.h"
#include "kernel/CombinedKernel.h"

#include <unistd.h>

#ifdef USE_CPLEX
extern "C" {
#include <ilcplex/cplex.h>
}
#endif

#include "base/Parallel.h"

#ifndef WIN32
#include <pthread.h>
#endif

using namespace shogun;

CSVMLightOneClass::CSVMLightOneClass(float64_t C, CKernel* k)
: CSVMLight()
{
	set_C(C,C);
	set_kernel(k);
}

CSVMLightOneClass::CSVMLightOneClass()
: CSVMLight()
{
}

bool CSVMLightOneClass::train(CFeatures* data)
{
	//certain setup params
	mkl_converged=false;
	verbosity=1 ;
	init_margin=0.15;
	init_iter=500;
	precision_violations=0;
	opt_precision=DEF_PRECISION;

	strcpy (learn_parm->predfile, "");
	learn_parm->biased_hyperplane=0;
	learn_parm->sharedslack=0;
	learn_parm->remove_inconsistent=0;
	learn_parm->skip_final_opt_check=0;
	learn_parm->svm_maxqpsize=get_qpsize();
	learn_parm->svm_newvarsinqp=learn_parm->svm_maxqpsize-1;
	learn_parm->maxiter=100000;
	learn_parm->svm_iter_to_shrink=100;
	learn_parm->svm_c=C1;
	learn_parm->transduction_posratio=0.33;
	learn_parm->svm_costratio=C2/C1;
	learn_parm->svm_costratio_unlab=1.0;
	learn_parm->svm_unlabbound=1E-5;
	learn_parm->epsilon_crit=epsilon; // GU: better decrease it ... ??
	learn_parm->epsilon_a=1E-15;
	learn_parm->compute_loo=0;
	learn_parm->rho=1.0;
	learn_parm->xa_depth=0;

    if (!kernel)
        SG_ERROR( "SVM_light can not proceed without kernel!\n");

	if (data)
		kernel->init(data, data);

    if (!kernel->has_features())
        SG_ERROR( "SVM_light can not proceed without initialized kernel!\n");

	int32_t num_vec=kernel->get_num_vec_lhs();
	SG_INFO("num_vec=%d\n", num_vec);

	SG_UNREF(labels);
	labels=new CLabels(num_vec);
	labels->set_to_one();

	// in case of LINADD enabled kernels cleanup!
	if (kernel->has_property(KP_LINADD) && get_linadd_enabled())
		kernel->clear_normal() ;

	// output some info
	SG_DEBUG( "threads = %i\n", parallel->get_num_threads()) ;
	SG_DEBUG( "qpsize = %i\n", learn_parm->svm_maxqpsize) ;
	SG_DEBUG( "epsilon = %1.1e\n", learn_parm->epsilon_crit) ;
	SG_DEBUG( "kernel->has_property(KP_LINADD) = %i\n", kernel->has_property(KP_LINADD)) ;
	SG_DEBUG( "kernel->has_property(KP_KERNCOMBINATION) = %i\n", kernel->has_property(KP_KERNCOMBINATION)) ;
	SG_DEBUG( "kernel->has_property(KP_BATCHEVALUATION) = %i\n", kernel->has_property(KP_BATCHEVALUATION)) ;
	SG_DEBUG( "kernel->get_optimization_type() = %s\n", kernel->get_optimization_type()==FASTBUTMEMHUNGRY ? "FASTBUTMEMHUNGRY" : "SLOWBUTMEMEFFICIENT" ) ;
	SG_DEBUG( "get_solver_type() = %i\n", get_solver_type());
	SG_DEBUG( "get_linadd_enabled() = %i\n", get_linadd_enabled()) ;
	SG_DEBUG( "get_batch_computation_enabled() = %i\n", get_batch_computation_enabled()) ;
	SG_DEBUG( "kernel->get_num_subkernels() = %i\n", kernel->get_num_subkernels()) ;

	use_kernel_cache = !((kernel->get_kernel_type() == K_CUSTOM) ||
						 (get_linadd_enabled() && kernel->has_property(KP_LINADD)));

	SG_DEBUG( "use_kernel_cache = %i\n", use_kernel_cache) ;

	if (kernel->get_kernel_type() == K_COMBINED)
	{
		CKernel* kn = ((CCombinedKernel*)kernel)->get_first_kernel();

		while (kn)
		{
			// allocate kernel cache but clean up beforehand
			kn->resize_kernel_cache(kn->get_cache_size());
			SG_UNREF(kn);
			kn = ((CCombinedKernel*) kernel)->get_next_kernel();
		}
	}

	kernel->resize_kernel_cache(kernel->get_cache_size());

	// train the svm
	svm_learn();

	// brain damaged svm light work around
	create_new_model(model->sv_num-1);
	set_bias(-model->b);
	for (int32_t i=0; i<model->sv_num-1; i++)
	{
		set_alpha(i, model->alpha[i+1]);
		set_support_vector(i, model->supvec[i+1]);
	}

	// in case of LINADD enabled kernels cleanup!
	if (kernel->has_property(KP_LINADD) && get_linadd_enabled())
	{
		kernel->clear_normal() ;
		kernel->delete_optimization() ;
	}

	if (use_kernel_cache)
		kernel->kernel_cache_cleanup();

	return true ;
}
#endif //USE_SVMLIGHT
