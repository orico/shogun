using System;

using org.shogun;
using org.jblas;
// This Java 'import static' statement cannot be converted to .NET:
import static org.jblas.DoubleMatrix.randn;

public class evaluation_meansquarederror_modular
{
	static evaluation_meansquarederror_modular()
	{
// The library is specified in the 'DllImport' attribute for .NET:
//		System.loadLibrary("modshogun");
	}

	static void Main(string[] argv)
	{
		modshogun.init_shogun_with_defaults();
		int N = 100;

		DoubleMatrix ground_truth = randn(1, N);
		DoubleMatrix predicted = randn(1, N);

		Labels ground_truth_labels = new Labels(ground_truth);
		Labels predicted_labels = new Labels(predicted);

		MeanSquaredError evaluator = new MeanSquaredError();
		double mse = evaluator.evaluate(predicted_labels, ground_truth_labels);

		Console.WriteLine(mse);

		modshogun.exit_shogun();
	}
}
