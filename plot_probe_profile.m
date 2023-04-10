function[] = plot_probe_profile(img,x,N)
b = N/2-round(0.4*N) : N/2+(round(0.4*N)-1); % Display range
img = img(N/2,:);
figure(4);
plot(x(b)*1e+9,img(b),'--','LineWidth',2);
axis square; axis xy;
xlabel('x (nm)');
ylabel('Normalized e- probe intensity');
title('e- Probe profile at the  specimen');
end