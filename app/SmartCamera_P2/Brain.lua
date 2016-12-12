smartCamera = {}

function smartCamera.processNumber(operand) 
    
	local weightMatrix = {}
	local biasVector = {}
	local multiplicationResult = {{1,2,3,4,5,6,7,8,9,10,11}}
	local resultVector = {{1,2,3,4,5,6,7,8,9,10,11}}
					
	-- 1. Read weight matrix	
		local path = system.pathForFile( "weights.txt", system.ResourceDirectory )

			local file, errorString = io.open( path, "r" )

			if not file then
				local alert = native.showAlert( "Smart Camera Warning", "Erro lendo arquivo de pesos", { "OK"})
			else
				for line in file:lines() do
					local s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 = line:match '(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)'
					n1 = tonumber(s1);
					n2 = tonumber(s2);
					n3 = tonumber(s3);
					n4 = tonumber(s4);
					n5 = tonumber(s5);
					n6 = tonumber(s6);
					n7 = tonumber(s7);
					n8 = tonumber(s8);
					n9 = tonumber(s9);
					n10 = tonumber(s10);
					n11 = tonumber(s11);
					table.insert(weightMatrix, { n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11 })
				end
				io.close( file )
			end

			file = nil;
	------------------------
	-- 2. Read bias vector
		local path = system.pathForFile( "biases.txt", system.ResourceDirectory )

			local file, errorString = io.open( path, "r" )

			if not file then
				local alert = native.showAlert( "Smart Camera Warning", "Erro lendo arquivo de biases", { "OK"})
			else
				for line in file:lines() do
					local s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 = line:match '(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)'
					n1 = tonumber(s1);
					n2 = tonumber(s2);
					n3 = tonumber(s3);
					n4 = tonumber(s4);
					n5 = tonumber(s5);
					n6 = tonumber(s6);
					n7 = tonumber(s7);
					n8 = tonumber(s8);
					n9 = tonumber(s9);
					n10 = tonumber(s10);
					n11 = tonumber(s11);
					--print("biases: ".. n1 .." , ".. n2 .." , ".. n3 .." , "..n4.." , "..n5.." , ".. n6.." , ".. n7.." , ".. n8.." , ".. n9.." , "..n10.." , "..n11)
					table.insert(biasVector, { n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11 })
				end
				io.close( file )
			end

			file = nil;
	------------------------
	-- 3. Do the math (RESULT = INPUT*WEIGHT + BIAS)

		-- Multiply input by weights
		for i=1, 1 do
			for j=1, 11 do
				sum = 0;
				for k=1, 784 do
					sum = sum + operand[k]*weightMatrix[k][j];
				end
				multiplicationResult[i][j] = sum;
			end
		end

		-- Add biases
		for j=1, 11 do
			resultVector[1][j] = multiplicationResult[1][j] + biasVector[1][j]
		end
	------------------------
	-- 4. Process the result

		-- Find the index of the highest value in the result vector
		local winnerIndex = 0
		local maxValue = 0

		--for j=1, 11 do
				--print("Result Vector["..j.."] = " .. resultVector[1][j]);
		--end

		for j=1, 11 do
			if (resultVector[1][j] > maxValue) then
				maxValue = resultVector[1][j]
				winnerIndex = j
			end
			--print("Winner is element "..winnerIndex..", with value of "..maxValue)			
		end
	------------------------
	-- 5. Return the result corresponding to the winner index
		if (winnerIndex == 11) then 
			return 99
		end

		return (winnerIndex-1);
end

function smartCamera.processOperation(operator) 
    
	local weightMatrix = {}
	local biasVector = {}
	local multiplicationResult = {{1,2,3}}
	local resultVector = {{1,2,3}}
					
	-- 1. Read weight matrix	
		local path = system.pathForFile( "weights_op_all.txt", system.ResourceDirectory )

			local file, errorString = io.open( path, "r" )

			if not file then
				local alert = native.showAlert( "Smart Camera Warning", "Erro lendo arquivo de pesos", { "OK"})
			else
				local a = 1
				for line in file:lines() do
					local s1, s2, s3 = line:match '(%S+)%s+(%S+)%s+(%S+)'
					n1 = tonumber(s1);
					n2 = tonumber(s2);
					n3 = tonumber(s3);
					--print("Weights -- line ".. a..": ".. n1 .." , ".. n2 .." , ".. n3)
					a = a+1
					table.insert(weightMatrix, { n1, n2, n3 })
				end
				io.close( file )
			end

			file = nil;
	------------------------
	-- 2. Read bias vector
		local path = system.pathForFile( "biases_op_all.txt", system.ResourceDirectory )

			local file, errorString = io.open( path, "r" )

			if not file then
				local alert = native.showAlert( "Smart Camera Warning", "Erro lendo arquivo de biases", { "OK"})
			else
				for line in file:lines() do
					local s1, s2, s3 = line:match '(%S+)%s+(%S+)%s+(%S+)'
					n1 = tonumber(s1);
					n2 = tonumber(s2);
					n3 = tonumber(s3);
					--print("biases: ".. n1 .." , ".. n2 .." , ".. n3)
					table.insert(biasVector, { n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11 })
				end
				io.close( file )
			end

			file = nil;
	------------------------
	-- 3. Do the math (RESULT = INPUT*WEIGHT + BIAS)

		-- Multiply input by weights
		for i=1, 1 do
			for j=1, 3 do
				sum = 0;
				for k=1, 784 do
					sum = sum + operator[k]*weightMatrix[k][j];
				end
				multiplicationResult[i][j] = sum;
			end
		end

		-- Add biases
		for j=1, 3 do
			resultVector[1][j] = multiplicationResult[1][j] + biasVector[1][j]
		end
	------------------------
	-- 4. Process the result

		-- Find the index of the highest value in the result vector
		local winnerIndex = 0
		local maxValue = 0

		--for j=1, 3 do
		--		print("Result Vector["..j.."] = " .. resultVector[1][j]);
		--end

		for j=1, 3 do
			if (resultVector[1][j] > maxValue) then
				maxValue = resultVector[1][j]
				winnerIndex = j
			end
			--print("Winner is element "..winnerIndex..", with value of "..maxValue)			
		end
	------------------------
	-- 5. Return the result corresponding to the winner index
	local operation

		if (winnerIndex == 1) then 
			operation = "x"
		elseif (winnerIndex == 2) then
			operation = "+"
		elseif (winnerIndex == 3) then
			operation = "-"
		end

	return operation
end

function smartCamera.calculate(numA, numB, op)

	if op == "x" then
		return numA * numB
	elseif op == "+" then
		return numA + numB
	elseif op == "-" then
		return numA - numB
	end
end

return smartCamera