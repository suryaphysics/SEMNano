function [] = display_TF(img,x,y,N)
d = N/2-50 : N/2+49; % Display range
figure(2);imagesc(x(d),y(d),img(d,d));
axis square;
colormap('jet'); colorbar('Location','East','Color','w','FontSize',18');
xlabel('f_x (cycles/m)');
ylabel('f_y (cycles/m)');
title('Coherent tranfer function, A( f_x, f_y ), central crop');
    
end