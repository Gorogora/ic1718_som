       use AI::NeuralNet::SOM;

               # Create a new self-organizing map.
               $som = AI::NeuralNet::SOM->new();

               # Create a data set to initialize and train.
               @data = (
               13.575570, 12.656892, -1.424328, -2.302774, 404.921600,
               13.844373, 12.610620, -1.435429, -1.964423, 404.978180,
               13.996934, 12.669785, -1.384147, -1.830788, 405.187378,
               14.060876, 12.755087, -1.378407, -2.020230, 404.892548,
               14.095317, 12.877163, -1.363435, -2.072163, 404.698822,
               13.975704, 12.888503, -1.351579, -1.832351, 404.479889,
               13.713181, 12.836812, -1.338311, -1.997729, 403.891724,
               13.834728, 12.809576, -1.333899, -2.002055, 403.270264,
               13.744470, 12.770656, -1.343199, -2.241165, 402.820709,
               13.982540, 12.697198, -1.372424, -1.922313, 402.433960,
               14.064130, 12.691656, -1.377368, -1.752657, 403.218475,
               14.035974, 12.764489, -1.354782, -1.970408, 402.411560,
               14.037183, 12.913648, -1.322078, -2.069336, 402.292755,
               13.985688, 12.954960, -1.345922, -1.613702, 404.184143,
               14.054778, 12.941310, -1.384624, -1.703977, 399.970612,
               13.915499, 13.089429, -1.313017, -1.429557, 399.338287,
               14.590042, 13.462692, -1.290192, -1.537785, 399.777039,
               15.501397, 14.348173, -1.275527, -1.680045, 399.398071,
               15.630893, 15.530425, -1.280694, -1.917952, 400.034485,
               16.435490, 17.209114, -1.305744, -1.094125, 399.959900);

               # Initialize map.
               $som->initialize(3,3,5,'hexa','bubble','linear',0,\@data);

               # Find quantization error before training and print it.
               $qerr = $som->qerror(\@data);
               print "Mean quantization error before trainig= $qerr\n";

               # Train map with the same data set.
               $som->train(500,0.05,3,'linear',\@data);

               # Find quantization error after training and print it.
               $qerr = $som->qerror(\@data);
               print "Mean quantization error after trainig= $qerr\n\n";

               # Create a data set to label map.
               @label_data = (
               23.508335, 21.359016, 3.906102, 4.884908, 404.440765,
               23.823174, 21.731325, 4.295785, 5.244288, 405.100342,
               24.207268, 22.070162, 4.646249, 5.030964, 404.812225,
               24.284208, 22.401424, 4.806539, 5.006081, 404.735596,
               24.401838, 22.588514, 4.957213, 5.011020, 404.176880,
               25.824610, 24.155489, 5.976608, 6.708979, 405.040466,
               26.197090, 24.353720, 6.272694, 6.843574, 405.728119,
               26.347252, 24.720333, 6.518201, 6.950599, 405.758606,
               26.537718, 24.976704, 6.661457, 7.163557, 404.037567,
               27.041384, 25.309855, 6.979992, 7.488787, 404.839081,
               27.193167, 25.601683, 7.173965, 7.920047, 404.749054);

               #Label map with "fault" patterns.
               $patterns_count = scalar(@label_data) / $som->i_dim;
               for $i (0..$patterns_count-1){
                       @pattern = splice(@label_data, 0, $som->i_dim);
                       ($x, $y) = $som->winner(\@pattern);
                       $som->set_label($x, $y, "fault");
               }

               # Create a data set to test map.
               @test_data = (
               23.508335, 21.359016, 3.906102, 4.884908, X,
               23.823174, 21.731325, 4.295785, 5.244288, 405.100342,
               24.207268, 22.070162, 4.646249, 5.030964, 404.812225,
               13.575570, 12.656892, -1.424328, -2.302774, 404.921600,
               24.284208, 22.401424, 4.806539, 5.006081, 404.735596,
               24.401838, 22.588514, 4.957213, 5.011020, 404.176880,
               13.844373, 12.610620, -1.435429, -1.964423, 404.978180,
               24.628309, 23.015909, 5.075150, 5.560286, 403.773132,
               13.996934, 12.669785, -1.384147, -1.830788, 405.187378,
               25.551638, 23.864803, 5.774306, 6.208019, 403.946777,
               26.347252, 24.720333, 6.518201, 6.950599, 405.758606,
               26.537718, 24.976704, 6.661457, 7.163557, 404.037567,
               X, 15.601683, X, X, 404.749054,
               27.041384, 25.309855, 6.979992, 7.488787, 404.839081);

               #Test map and print results.
               $patterns_count = scalar(@test_data) / $som->i_dim;
               for $i (0..$patterns_count-1){
                       @pattern = splice(@test_data, 0, $som->i_dim);
                       ($x, $y) = $som->winner(\@pattern);
                       $label=$som->label($x, $y);
                       if (defined($label)) {
                               print "@pattern - $label\n";
                       }
                       else {
                               print "@pattern\n";
                       }
               }