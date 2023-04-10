function [] = display_psf(img,x,y)

figure(1);imagesc(x,y,img);
axis square;
colormap('hot');colorbar('FontSize',18,'Color','b');
xlabel('x (m)');
ylabel('y (m)');
title('Coherent PSF of the lens system');
    
end

