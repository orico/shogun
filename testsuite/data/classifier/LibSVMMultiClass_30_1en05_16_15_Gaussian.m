classifier_name = 'LibSVMMultiClass';
classifier_C = 30;
classifier_epsilon = 1e-05;
init_random = 42;
kernel_feature_type = 'Real';
classifier_num_threads = 16;
classifier_labels = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0];
kernel_arg0_width = 1.5;
classifier_accuracy = 0.0001;
classifier_bias = 0.0;
kernel_data_train = [1.9007019, 0.4732099, 0.9681934, 0.1295149, 1.6229666, 1.6315602, 0.5800862, 0.3685263, 0.9556515, 1.8734232, 1.4217209, 1.5923503, 1.2106622, 0.5929399, 0.0914868, 0.7765969, 0.7709218, 0.0311341, 1.2768278, 0.8643582, 0.2656, 0.8447832, 0.2238176, 0.8621276, 1.9123633, 1.733113, 1.4866689, 0.8887481, 0.6516668, 0.1855255, 0.5369744, 0.8774609, 0.8686232;1.180977, 1.9090325, 1.2472311, 0.8095161, 0.6166503, 1.8543851, 1.9713951, 0.6262203, 0.7965373, 0.6855653, 0.2597538, 0.2201832, 0.0869868, 0.1173082, 0.0325262, 0.4815224, 1.715825, 1.1315677, 0.4084532, 0.761024, 1.2375433, 0.3726885, 1.4922779, 0.9208478, 0.7234201, 1.1796831, 0.1251858, 0.5508574, 0.4958757, 1.8707499, 0.655242, 0.0810462, 0.1312449;0.0724469, 0.6780162, 0.565732, 1.5148174, 0.6832588, 0.824681, 0.4552201, 0.5924078, 0.7975591, 0.3478092, 0.8512069, 0.4303059, 1.5929509, 0.2689934, 0.4805866, 1.7734731, 1.4453053, 0.4915945, 0.0761309, 1.2581334, 0.2005247, 1.6567367, 1.1635239, 1.9694123, 0.310362, 0.2670283, 0.4951465, 1.3592334, 1.3251901, 1.3910815, 0.0116205, 0.0642089, 0.5819714;0.6949819, 0.6584518, 0.2916626, 0.797426, 1.4537895, 0.0396188, 0.6801408, 0.8672942, 0.6000205, 0.708363, 0.779851, 1.4308875, 0.242045, 1.0734967, 0.6974715, 1.2487143, 0.87863, 1.2360505, 0.1049302, 0.4805069, 0.8505817, 1.1308737, 1.5197739, 0.8601224, 1.969821, 1.1697579, 0.4799388, 1.8288834, 0.6186114, 0.3924936, 0.8370133, 0.7527166, 1.3370032;1.0366714, 0.1288699, 1.4746309, 0.1424955, 0.4988882, 0.8321342, 0.9866626, 1.617145, 0.6181557, 0.0878665, 0.1586051, 1.8441704, 0.5177116, 0.8718435, 0.8808708, 0.1607599, 1.736402, 0.3351189, 0.3506269, 0.3264613, 0.0097708, 0.0292473, 0.8258168, 0.5596487, 0.702465, 1.8056702, 0.7435083, 1.5853544, 1.6638045, 1.1670419, 1.1676192, 1.7067772, 0.817967;1.1119196, 1.0393435, 1.9366057, 0.1674826, 0.0332031, 1.452199, 1.5311695, 0.6169269, 0.6340057, 1.1221099, 0.5074677, 1.8682713, 0.8005867, 1.933875, 0.6318135, 1.2058412, 0.2001502, 1.2697496, 1.0570869, 0.0063859, 0.0785785, 0.3969233, 0.5399854, 0.7798454, 0.1069806, 0.2598036, 0.2870381, 0.1327158, 0.9811862, 0.5675408, 0.6364302, 0.689465, 0.1045678;0.7140869, 0.0678371, 0.8709691, 0.0519713, 0.7090605, 1.5072348, 0.5412963, 0.8017281, 0.8148251, 0.3009636, 1.9866301, 1.9518118, 0.5412666, 0.7064757, 0.3394502, 1.6391199, 1.0415729, 1.4547399, 1.3161561, 0.9320281, 1.1483432, 1.9651187, 0.6878857, 0.962992, 1.00494, 0.7610279, 0.6326219, 0.9372285, 0.3418722, 0.9362122, 0.0315861, 0.1025097, 1.8679183;0.5264027, 0.1300862, 1.4888466, 1.0299736, 1.6668643, 1.0939007, 0.7315895, 0.0603521, 0.7081721, 0.4523183, 0.5475924, 0.7496518, 0.8715368, 0.9688779, 0.8172978, 1.1396513, 0.8948167, 0.6209155, 0.3458831, 1.7046808, 0.973489, 0.08163, 1.2018535, 1.3079299, 0.5821705, 0.6435777, 1.969912, 1.6734324, 0.0801148, 1.515596, 0.0673506, 0.045742, 0.2471032;0.2736267, 0.0221236, 1.4971748, 0.8717836, 0.219214, 0.9971245, 0.1821179, 0.9758653, 0.4261813, 0.0245869, 0.3236102, 1.9446142, 1.8681423, 1.6178472, 1.868905, 0.3368958, 0.6832954, 1.1771498, 0.7896985, 0.7704074, 1.692626, 0.5553636, 0.7582632, 0.1595447, 1.4437502, 1.683248, 0.4981957, 0.4886432, 0.7192018, 0.4459027, 0.6587078, 1.8381153, 1.6726021;0.9747932, 1.3938644, 1.651233, 1.0303871, 0.9963339, 0.6804993, 0.1995425, 1.6895268, 0.6545112, 0.462623, 1.6578453, 0.8682725, 0.6802282, 1.6588855, 0.0306525, 0.2284547, 0.9508636, 0.2207696, 0.6503257, 1.2156752, 1.106593, 0.082381, 0.0721984, 0.6936822, 1.5706097, 0.2576829, 0.7948095, 0.1510579, 0.451387, 0.2732595, 1.9309487, 1.6765134, 0.1636238;0.7252577, 0.7271691, 0.9839776, 0.8670315, 0.409334, 0.3975944, 0.3710388, 0.7427065, 1.4041403, 0.2131047, 1.9771742, 0.9876496, 0.2742152, 1.7384492, 1.9994137, 1.8785156, 0.6385259, 0.4323348, 1.406908, 0.2299546, 1.048212, 0.5786754, 1.3270332, 0.0401092, 1.5670163, 1.7823855, 1.8707535, 0.9436159, 0.4197273, 0.4386154, 0.345935, 0.8940992, 0.4254933];
classifier_label_type = 'series';
kernel_name = 'Gaussian';
classifier_alpha_sum = 0.0;
kernel_feature_class = 'simple';
classifier_sv_sum = 16896;
kernel_data_test = [0.6149782, 0.3647982, 0.8814508, 0.5644411, 1.2824309, 0.5386957, 0.1220351, 1.7507295, 1.1616198, 0.6575603, 1.1262538, 0.0003325, 0.8514486, 0.4338005, 0.1939539, 0.6878841, 0.1917825, 1.5579807, 0.5942908, 0.8761052, 0.5061076, 0.2777526, 0.2779021, 0.2325514, 1.0179457, 0.8151184, 0.0799654, 0.6025532, 1.3907284, 1.5525136, 1.7541077, 0.3752599, 0.3109289, 0.9364492, 0.7767236, 1.5601823, 0.5580423, 1.6596294, 0.8117522, 1.3719327, 0.7417121, 0.7423481, 0.8798165, 0.1608482, 1.946638, 0.3864608, 1.3436632, 1.0941519, 1.7983442, 0.0176878, 1.2554933;0.4846016, 0.4703191, 0.6194978, 0.4303372, 1.1958408, 0.7542535, 1.0940361, 0.5241592, 0.297355, 0.2326455, 0.1706648, 0.2653874, 0.2288946, 1.4516968, 1.3973814, 1.2764417, 0.6783788, 0.2172091, 0.7495455, 0.0110316, 0.5020502, 0.6916181, 1.4476029, 0.2117554, 0.8419704, 0.1247141, 1.356671, 0.3853759, 0.8480478, 0.6331896, 0.1777664, 0.6433652, 1.5578202, 1.1867233, 1.093408, 0.2208026, 0.7586764, 0.782696, 0.8326805, 1.1956093, 0.7562647, 0.7803998, 1.5201905, 1.7574819, 0.0746298, 1.6426747, 1.4410722, 0.6180517, 0.839964, 1.3123491, 1.8969579;0.4185806, 1.1660343, 1.313162, 1.8971863, 1.3636931, 0.7920936, 1.1688542, 0.4023271, 0.3876736, 0.1783726, 0.1737526, 0.7903377, 0.3542362, 0.1668851, 0.1813193, 0.8742625, 1.8203775, 0.4047984, 0.8480159, 0.6540758, 0.7029434, 0.0290714, 1.5981126, 1.0333836, 0.2485803, 0.2254388, 0.9638223, 0.1768871, 1.5070511, 0.4865977, 0.4816348, 0.5255046, 0.7234048, 1.7397303, 0.1338037, 0.3870788, 1.7326352, 1.117644, 0.5101097, 0.663042, 1.3631007, 1.9677559, 1.6134731, 0.052804, 0.1041374, 0.7243175, 0.6557237, 1.8568739, 0.1378229, 0.0018799, 1.7985933;1.485359, 0.6460901, 1.9734574, 0.5202966, 0.8343034, 1.9797825, 0.9819692, 1.3790271, 0.0229328, 0.0426332, 0.2358576, 0.1271998, 0.4993338, 1.0293642, 0.209842, 0.6021456, 1.3230112, 1.1298264, 0.3235004, 0.6809748, 0.6292988, 0.5821482, 0.6189482, 0.6364907, 0.1492378, 0.3714086, 0.1988563, 1.8229584, 1.7251855, 0.2660193, 0.2658511, 1.686861, 1.9970782, 0.1896948, 0.7355056, 0.371422, 0.3734626, 1.0930305, 0.0646167, 1.3196668, 1.988416, 0.599369, 1.656134, 0.322108, 0.8251307, 1.1224339, 0.6954156, 0.1489997, 0.7459252, 0.1223768, 1.2097529;0.7665885, 0.2530584, 0.243478, 0.3923937, 0.2994435, 0.0764169, 1.2443399, 1.3368405, 1.8798219, 1.3140608, 0.9303189, 1.9880656, 1.918208, 0.9911264, 0.8088835, 1.254322, 0.133145, 1.2964898, 0.7472196, 1.8192551, 0.1734801, 0.4961664, 1.7595824, 1.901296, 0.2029364, 0.7336158, 0.2793677, 0.56555, 0.8595652, 0.0625422, 0.8013669, 0.1021495, 1.5254349, 0.6859113, 0.1782525, 1.6516679, 0.6586921, 0.6517106, 0.6375533, 0.7399864, 1.7190774, 0.8106859, 0.9503128, 0.8646604, 1.0871795, 0.9428311, 0.9796467, 0.9562222, 0.6140813, 1.1107484, 1.1129432;1.8061959, 1.9053599, 0.5858101, 1.5772497, 0.6590355, 0.0380218, 0.8824594, 0.4432731, 0.1056935, 0.7462073, 0.8251322, 0.2255413, 0.706019, 1.1912604, 0.2269647, 1.0311156, 1.0038171, 0.480906, 0.0561361, 0.852728, 0.8893909, 0.4501244, 0.4351804, 1.7396713, 1.6816695, 0.4506197, 0.1652941, 1.3149196, 0.8021306, 0.4617328, 0.700252, 1.4355055, 1.1063437, 1.7392947, 0.0478308, 1.4201187, 0.7825819, 0.3769142, 0.7811704, 0.3863489, 1.6137774, 0.9882753, 1.8437373, 0.5864791, 1.2539749, 0.9373533, 0.6311706, 1.7380691, 0.4954521, 0.9296169, 0.6976706;0.0355709, 1.9036078, 1.9917426, 0.4619469, 1.807396, 1.2155299, 0.4720604, 0.0445949, 0.3548414, 1.3403801, 0.1053675, 1.0590939, 0.9423154, 0.7838427, 1.0685054, 0.0826177, 0.5085793, 0.8305345, 0.97075, 0.3875952, 0.0070292, 1.167132, 0.2756123, 0.0134026, 0.0687128, 0.7802131, 0.2827457, 1.2327631, 0.049842, 1.7631553, 0.1313494, 1.3603778, 1.077078, 0.9226231, 0.4242969, 0.0572803, 0.2252237, 0.2757199, 0.4121309, 1.0726709, 1.6552824, 1.7592487, 0.0362876, 0.398836, 0.9039133, 0.5146576, 0.9915884, 0.549616, 1.4083063, 1.8663865, 0.9093902;0.0104277, 0.6196994, 0.4782553, 1.0001884, 0.268139, 1.3795029, 1.8742267, 1.1288487, 0.3712071, 1.4127611, 0.0692543, 1.1690811, 0.1252336, 0.8530896, 0.3222155, 0.2367843, 1.9662434, 1.3897594, 0.6673504, 0.9759908, 0.8989008, 1.421444, 1.6507685, 0.2554135, 0.5619928, 0.4860155, 0.0465006, 0.2607133, 0.7871266, 0.9748347, 1.2267304, 0.4743361, 0.7324487, 0.3151895, 1.8988474, 0.1563818, 0.7824849, 0.8958146, 1.0180001, 0.4288869, 0.9598265, 0.2278424, 1.3816119, 1.027175, 0.3459204, 0.8447894, 0.0864246, 0.1139566, 0.7718577, 1.8023543, 1.4790701;0.5500919, 1.1202472, 1.2633158, 0.4944811, 0.5483206, 1.9817987, 0.3934478, 0.9673562, 1.4498422, 0.1636838, 0.8278684, 0.1449651, 0.0437356, 0.8821356, 0.3759929, 1.6350891, 0.9202972, 1.6993154, 0.787713, 1.5591848, 1.5326759, 1.6282381, 0.5985316, 0.1911907, 0.6759823, 0.6244254, 1.6213445, 0.9795508, 1.0683409, 1.7076883, 0.7251557, 0.110808, 1.9727763, 1.8394609, 0.0127149, 0.5207681, 0.4960478, 1.2184432, 0.1279882, 0.1830154, 0.947036, 0.2737913, 0.9283175, 0.6164997, 0.0950117, 1.127454, 0.3886528, 1.8260391, 0.3086987, 0.3382631, 0.1566384;1.330408, 1.2838284, 1.0742409, 1.8772395, 0.6360708, 1.5313165, 0.720008, 0.3169225, 0.9924154, 1.8245348, 0.5425458, 0.2693313, 0.2274095, 0.2584316, 1.3404058, 0.4039779, 1.6261762, 0.0888402, 1.7302461, 0.5440166, 1.2263515, 0.5488387, 1.5988083, 0.5395562, 0.1409596, 0.9783973, 0.5578132, 0.4286305, 1.0644913, 1.0461236, 0.6714549, 1.8772618, 0.2261471, 0.1805946, 0.0220352, 1.9890284, 0.5451055, 0.0538582, 0.8792687, 0.6129002, 0.6837541, 0.7531873, 0.9805168, 0.7917, 0.3200598, 0.8469187, 0.4179899, 0.2210634, 1.5671708, 1.8381522, 0.7481919;0.758425, 1.6588251, 0.6641879, 0.5771728, 0.1515694, 0.3423836, 0.7279472, 0.9780618, 0.4972559, 0.1079437, 0.685298, 1.4883746, 1.0326457, 0.1506761, 1.0646869, 0.8721357, 1.2202253, 1.7891608, 0.9651297, 0.3397775, 0.4601623, 1.9558245, 0.0975625, 1.2852903, 0.4134164, 1.5733493, 0.0937569, 0.0918709, 1.5252398, 0.7434238, 1.8685515, 0.2905876, 1.2523072, 1.025142, 1.4291826, 0.8619869, 1.7375657, 0.758185, 0.7869701, 0.3559734, 0.5448478, 0.7939897, 0.1119359, 0.7492837, 0.8771384, 1.2677767, 0.6119405, 0.4883941, 0.2160905, 0.1059307, 1.6944505];
classifier_classified = [30, 13, 21, 23, 21, 20, 29, 25, 31, 19, 28, 8, 28, 6, 8, 28, 3, 25, 7, 28, 3, 20, 16, 28, 9, 8, 3, 17, 8, 18, 26, 17, 22, 12, 26, 30, 8, 8, 8, 0, 11, 21, 23, 6, 0, 22, 0, 12, 0, 2, 22];
classifier_type = 'kernel';