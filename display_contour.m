function [] = display_contour(img,x,y,N)
b = N/2-round(0.4*N) : N/2+(round(0.4*N)-1); % Display range
figure(3);
contour(x(b)*1e+9,y(b)*1e+9,flipud(img(b,b))); 
axis square; axis xy;
colormap('parula'); %colorbar('Location','East','Color','black');
xlabel('x (nm)');
ylabel('y (nm)');
set(gca,'FontSize',18)
title('e- Probe intensity contour Plot central crop');
end

