function createGif(name,X,Y,u,times,every,ax)
% creates gif movie form 3D array

% save results to gif file
gifka = name;
clf;
pic = surf(X,Y,squeeze(u(1,:,:))),axis(ax);
for i=1:every:times 
    set(pic,'zdata',squeeze(u(i,:,:))), drawnow;
    M(i) = getframe;
    frame = getframe;
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 1;
        imwrite(imind,cm,gifka,'gif','Loopcount',inf);
    else
        imwrite(imind,cm,gifka,'gif','WriteMode','append','DelayTime',.1);
    end
end


end