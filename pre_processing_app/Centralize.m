
% Centralize the contents of a matrix in relation to its center of mass
function [ matrix ] = Centralize( matrix, x, y)
    % Define matrix center
        maxX = 12;
        maxY = 12;
        centerX = maxX/2 + 1;
        centerY = maxY/2 + 1;

    % Move matrix values horizontally
        if (x > centerX)
            %move left
            numberOfMoves = x - centerX;           
            for i=numberOfMoves:-1:1
                for col=2:maxX
                    for row=1:maxY
                        matrix(row,col-1) = matrix(row,col);
                    end
                end
            end         
            % Fill border with 0s
            for col=maxX:-1:(maxX-(numberOfMoves-1))
                for row=1:maxY
                    matrix(row,col) = 0;
                end
            end         
        else
            if(x < centerX)
                %move right
                numberOfMoves = centerX - x;
                for i=numberOfMoves:-1:1
                    for col=(maxX-1):-1:1
                        for row=1:maxY
                            matrix(row,col+1) = matrix(row,col);
                        end
                    end
                end         
                % Fill border with 0s
                for col=1:numberOfMoves
                    for row=1:maxY
                        matrix(row,col) = 0;
                    end
                end 
            end
        end
        
    % Move matrix values vertically
        if (y > centerY)
            %move up
            numberOfMoves = y - centerY;
            for i=numberOfMoves:-1:1
                for row=2:maxY
                    for col=1:maxX
                        matrix(row-1,col) = matrix(row,col);
                    end
                end
            end           
            % Fill border with 0s
            for row=maxY:-1:(maxY-(numberOfMoves-1))
                for col=1:maxX
                    matrix(row,col) = 0;
                end
            end   
        else
            if(y < centerY)
                %move down
                numberOfMoves = centerY - y;
                for i=numberOfMoves:-1:1
                    for row=(maxY-1):-1:1
                        for col=1:maxX
                            matrix(row+1,col) = matrix(row,col);
                        end
                    end
                end         
                % Fill border with 0s
                for row=1:numberOfMoves
                    for col=1:maxX
                        matrix(row,col) = 0;
                    end
                end 
            end
        end
    
        %return centralizedMatrix
end

