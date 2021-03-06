using System;

using org.shogun;
using org.jblas;
// This Java 'import static' statement cannot be converted to .NET:
import static org.jblas.DoubleMatrix.randn;

public class kernel_auc_modular
{
	static kernel_auc_modular()
	{
// The library is specified in the 'DllImport' attribute for .NET:
//		System.loadLibrary("modshogun");
	}

	static void Main(string[] argv)
	{
		modshogun.init_shogun_with_defaults();
		double width = 1.6;

		DoubleMatrix train_real = Load.load_numbers("../data/fm_train_real.dat");
		DoubleMatrix trainlab = Load.load_labels("../data/label_train_twoclass.dat");

		RealFeatures feats_train = new RealFeatures(train_real);
		GaussianKernel subkernel = new GaussianKernel(feats_train, feats_train, width);


		Labels labels = new Labels(trainlab);

		AUCKernel kernel = new AUCKernel(0, subkernel);
		kernel.setup_auc_maximization(labels);

		DoubleMatrix km_train = kernel.get_kernel_matrix();
		Console.WriteLine(km_train.ToString());

		modshogun.exit_shogun();
	}
}
