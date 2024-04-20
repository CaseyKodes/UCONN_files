#       CSE 3666 dot-product

        .data
        .align 2

# 256 floats
fvalues:     .float   
0.062, 0.819, 0.266, 0.342, 0.659, 0.728, 0.067, 0.352,
0.367, 0.244, 0.368, 0.783, 0.281, 0.080, 0.160, 0.907,
0.519, 0.639, 0.614, 0.734, 0.463, 0.993, 0.709, 0.724,
0.501, 0.735, 0.846, 0.331, 0.103, 0.600, 0.244, 0.059,
0.655, 0.139, 0.586, 0.423, 0.090, 0.849, 0.527, 0.744,
0.097, 0.938, 0.388, 0.586, 2.160, 0.496, 0.127, 0.757,
1.041, 0.353, 0.638, 0.797, 0.776, 0.455, 0.437, 0.920,
0.225, 0.464, 0.180, 0.439, 0.284, 0.882, 0.831, 0.794,
0.398, 2.400, 0.664, 9.885, 0.863, 0.556, 0.294, 0.816,
0.206, 0.150, 0.555, 0.448, 0.781, 0.065, 0.703, 0.092,
0.455, 0.415, 0.469, 0.172, 0.327, 0.235, 0.432, 0.616,
0.735, 1.675, 0.256, 0.900, 0.745, 0.475, 0.602, 0.470,
0.146, 0.729, 0.373, 0.773, 0.302, 0.324, 0.823, 0.362,
0.662, 0.219, 0.307, 0.849, 0.870, 0.980, 0.951, 0.157,
0.714, 4.267, 0.706, 0.572, 0.820, 0.715, 0.019, 0.778,
0.036, 0.706, 0.317, 0.056, 0.984, 0.957, 0.840, 0.479,
5.454, 9.153, 3.632, 7.090, 8.182, 4.060, 4.812, 6.793,
1.947, 4.969, 7.698, 1.604, 4.987, 4.478, 5.336, 5.641,
7.053, 4.105, 5.531, 9.643, 1.427, 8.522, 6.345, 9.816,
9.418, 3.588, 0.899, 8.818, 0.667, 3.985, 5.589, 3.851,
5.196, 5.410, 7.605, 0.585, 0.185, 6.764, 6.668, 1.258,
4.589, 0.856, 3.921, 0.979, 6.045, 3.206, 7.154, 7.044,
3.877, 8.257, 7.133, 4.089, 6.154, 8.397, 4.953, 9.697,
2.479, 6.635, 6.123, 8.337, 5.758, 2.033, 3.145, 2.976,
6.171, 8.586, 2.337, 4.797, 1.694, 7.632, 1.046, 7.413,
0.416, 0.577, 0.338, 5.373, 8.134, 2.571, 9.457, 2.755,
2.327, 3.042, 0.413, 6.999, 5.263, 7.459, 1.973, 2.584,
0.372, 3.720, 4.790, 7.144, 5.012, 3.351, 5.408, 9.538,
4.883, 3.717, 5.721, 6.249, 1.303, 5.568, 9.146, 0.746,
0.541, 7.922, 6.837, 2.184, 9.766, 3.260, 8.067, 1.016,
6.337, 7.220, 9.630, 8.189, 8.215, 5.273, 2.293, 7.353,
8.917, 8.391, 4.820, 5.856, 1.922, 7.170, 2.824, 2.276,

        .globl  main
        .text
main:   

        # The immeidate in the ADDI instruction is the array size
        # Change it to different values to test the code
        # The following are expected results when the immediate is 64, 128, and 200 
        # 64:  22.980118
        # 100: 36.73575
        # 128: 74.43233
        # 200: 1825.4126
        addi     a2, x0, 200            # change the immediate for a different array size
        lui      a0, 0x10010
        addi     a1, zero, 32
        add      a1, a0, a1
        jal      ra, dot_product
        
        addi     a7, x0, 2              # print float
        ecall

exit:   addi    a7, x0, 10
        ecall

# code to impliment
# 	float dot_product(float x[ ], float y[ ], int n) {
#		float sum = 0.0;
#		for (int i = 0; i < n; i += 1)
#			sum += x[i] * y[i];
#		return sum; }

# float dot_product(float x[], float y[], int n)
dot_product:
	# f0 floating point 0 
        fcvt.s.w f0, x0
        # f1 is representing sum 
        fadd.s f1, f0, f0, dyn
        # convert s0 to floating point number
        add t0, x0, x0 # used as counter
	blt t0, a2, loop # if counter less than n 
	beq x0, x0, end
        loop:
        	# get floats from memory 
        	flw f2, 0(a0) # represents x[i]
        	flw f3, 0(a1) # represents y[i]
        	# move index of array of floats 
        	# using 4 because all values in array are 4 digits long
        	addi a1, a1, 4 # y[]
        	addi a0, a0, 4 # x[]
        	fmadd.s f1, f2, f2, f1 # equivalent to f1 = f2*f3+f1
        	addi t0, t0, 1 # incriment counter
        	blt t0, a2, loop # if counter less than n rerun loop
        end:
        # convert to integer so we can return from function
        fcvt.w.s a0, f1
        jalr ra, x0, 0
