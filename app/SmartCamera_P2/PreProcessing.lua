smartProcessing = {}

-- Invert the values of a 28x28 matrix
function smartProcessing.invert(matrix)
	-- Invert matrix
		for line=1, 28 do
			for col=1, 28 do
				matrix[line][col] = matrix[line][col] - 1
				if (matrix[line][col] < 0 ) then
					matrix[line][col] = matrix[line][col]*(-1)
				end
			end
		end
	return(matrix)
end

-- Filter pixel values of a 28x28 matrix
function smartProcessing.filter(matrix)
	-- Identify pixel average
		local average = 0
		local sum = 0
		local numberOfElements = 784
		local maxValue = 0
		
		for line=1, 28 do
			for col=1, 28 do
				sum = sum + matrix[line][col]
				if (matrix[line][col] > maxValue) then
					maxValue = matrix[line][col]
				end
			end
		end

		average = sum/numberOfElements
		print("Pixel Average is: ".. average)	
		print("Max is: ".. maxValue)

	-- Filter pixel values
		for line=1, 28 do
			for col=1, 28 do
				if (matrix[line][col] < (1.33*average) ) then --considering average is not centered
					matrix[line][col] = 0

				elseif (matrix[line][col] >= (maxValue + average)/2 ) and (matrix[line][col] < 0.8*maxValue) then
					matrix[line][col] = 0.7
				else
					matrix[line][col] = 1
				end
			end
		end
	return(matrix)
end

-- Find the center of mass of a 28x28 matrix
function smartProcessing.centerOfMass(data)

	local cm_x, cm_y = 0, 0
    local sum_x, sum_y, total = 0, 0, 0
    
    -- calculating the total mass
    for y=1, 28 do
        for x=1, 28 do
            total = total + data[x][y]
        end
    end

    for y=1, 28 do
        for x=1, 28 do
            sum_x = sum_x + y*(data[x][y])/total
            sum_y = sum_y + x*(data[x][y])/total   
        end
    end

    cm_x = sum_x
    cm_y = sum_y

	return cm_x, cm_y
end

-- Centralize the center of mass of a 28X28 matrix
function smartProcessing.centralize(matrix, x, y)
    -- Define matrix center
        local maxX, maxY = 28, 28
        local centerX = maxX/2 + 1
        local centerY = maxY/2 + 1
		local numberOfMoves


    -- Move matrix values horizontally--
        if (x > centerX) then
            --move left
            numberOfMoves = x - centerX;           
            for i=numberOfMoves, 1, -1 do
                for col=2, maxX do
                    for row=1, maxY do
                        matrix[row][col-1] = matrix[row][col]
                    end
                end
            end         
            -- Fill border with 0s
            for col=maxX, (maxX-(numberOfMoves-1)), -1 do
                for row=1, maxY do
                    matrix[row][col] = 0
                end
            end         
        else
            if(x < centerX) then
                --move right
                numberOfMoves = centerX - x
                for i=numberOfMoves, 1, -1 do 
                    for col=(maxX-1), 1, -1 do
                        for row=1, maxY do
                            matrix[row][col+1] = matrix[row][col]
                        end
                    end
                end         
                -- Fill border with 0s
                for col=1, numberOfMoves do
                    for row=1, maxY do
                        matrix[row][col] = 0
                    end
                end 
            end
        end
        
	-- Move matrix values vertically
        if (y > centerY) then
            --move up
            numberOfMoves = y - centerY;
            for i=numberOfMoves, 1, -1 do
                for row=2, maxY do
                    for col=1, maxX do
                        matrix[row-1][col] = matrix[row][col]
                    end
                end
            end           
            -- Fill border with 0s
            for row=maxY, (maxY-(numberOfMoves-1)), -1 do
                for col=1, maxX do
                    matrix[row][col] = 0
                end
            end   
        else
            if(y < centerY) then
                --move down
                numberOfMoves = centerY - y;
                for i=numberOfMoves, 1, -1 do
                    for row=(maxY-1), 1, -1 do
                        for col=1, maxX do
                            matrix[row+1][col] = matrix[row][col]
                        end
                    end
                end         
                -- Fill border with 0s
                for row=1, numberOfMoves do
                    for col=1, maxX do
						matrix[row][col] = 0
                    end
                end 
            end
        end

	return matrix
end

-- Return a 1x784 vector from a 28x28 matrix
function smartProcessing.matrixToVector(matrix)

	local vector = {}
	local vectorIndex = 1

	for line=1, 28 do
		for col=1, 28 do 
			vector[vectorIndex] = matrix[line][col]
			vectorIndex = vectorIndex + 1
		end
	end

	return vector

end

return smartProcessing