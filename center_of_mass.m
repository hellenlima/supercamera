a = [0,0,0,1;0 0 1 0; 0, 1, 0, 0; 1, 0, 0, 0];
mean_x = mean(a,1);
mean_y = mean(a,2);

cm_x = mean_x/sum(a(:));
cm_x = sum(cm_x);

cm_y = mean_y/sum(a(:));
cm_y = sum(cm_y);