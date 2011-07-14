using System;

using org.shogun;
using org.jblas;
public class regression_krr_modular
{
	static regression_krr_modular()
	{
		System.loadLibrary("Features");
		System.loadLibrary("Kernel");
		System.loadLibrary("Regression");
		System.loadLibrary("Classifier");
	}

	static void Main(string[] argv)
	{
		Features.init_shogun_with_defaults();
		double width = 0.8;
		double tau = 1e-6;

		DoubleMatrix traindata_real = Load.load_numbers("../data/fm_train_real.dat");
		DoubleMatrix testdata_real = Load.load_numbers("../data/fm_test_real.dat");

		DoubleMatrix trainlab = Load.load_labels("../data/label_train_twoclass.dat");

		RealFeatures feats_train = new RealFeatures(traindata_real);
		RealFeatures feats_test = new RealFeatures(testdata_real);
		GaussianKernel kernel = new GaussianKernel(feats_train, feats_train, width);

		Labels labels = new Labels(trainlab);

		KRR krr = new KRR(tau, kernel, labels);
		krr.train(feats_train);

		kernel.init(feats_train, feats_test);
		DoubleMatrix out_labels = krr.apply().get_labels();
		Console.WriteLine(out_labels.ToString());

		Features.exit_shogun();
	}
}
