function [mse, rmse] = RMSE2(signal1, signal2)

% originalRowSize = size(signal1,1);
% originalColSize = size(signal1,2);
% 
% signal1 = double(signal1(:));
% signal2 = double(signal2(:));
% signal3=signal1 - signal2;
% mse = 10*log10(sum((signal1 - signal2).^2)/(originalRowSize*originalColSize));


if (size(signal1) ~= size(signal2))
   error('The size of the 2 matrix are unequal')

   mse_Value = NaN;
   return; 
elseif (signal1 == signal2)
   disp('Images are identical: PSNR has infinite value')

   mse_Value = Inf;
   return;   
else

    maxValue = double(max(signal1(:)));

    % Calculate MSE, mean square error.
    signal3 = (double(signal1) - double(signal2)) .^ 2;
    [rows columns] = size(signal1);
    
    mse = 10*log10(sum(signal3(:)) ./ (rows * columns));
    rmse = 10*log10(sqrt(mse));

    % Calculate PSNR (Peak Signal to noise ratio)
    
end

end

