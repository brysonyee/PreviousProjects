function  doublepend( a,b,ic,n )
%a is the initial time
%b is the terminal time
%ic is the 2x1 vector of initial values
%n is the number of time steps

h = (b-a)/n;
y(1,:) = ic;
t(1)=a;
set(gca,'xlim',[-1.2 1.2],'ylim',[-1.2 1.2],'XTick',[-1 0 1],'YTick',...
    [-1 0 1], 'Drawmode','fast','Visible','on','NextPlot','add');
cla;
axis square
bob = line('color','r','Marker','.','markersize',40, 'erase','xor',...
    'xdata',[],'ydata',[]);
rod = line('color','b','LineStyle','-','LineWidth',3, 'erase','xor',...
    'xdata',[],'ydata',[]);
bob2 = line('color','b','Marker','.','markersize',40,...
    'erase','xor','xdata',[],'ydata',[]);
rod2 = line('color','r','LineStyle','-','LineWidth',3,...
    'erase','xor','xdata',[],'ydata',[]);
%%%%
%
%Insert 1-step method code here.
%
%%%
for k=1:n
    t(k+1) = t(k) +h;
    y(k+1,:) = EulerStep_pend(y(k,:),h);
    %y(k+1,:) = trapstep_pend(y(k,:),h);
    %x and y coordinates of the bob
    xbob = sin(y(k+1,1)); 
    ybob = -cos(y(k+1,1));
    x2bob = xbob+sin(y(k+1,3)); 
    y2bob = ybob+cos(y(k+1,3));
    xrod = [0 xbob]; 
    yrod = [0 ybob];
    x2rod = [xbob x2bob];
    y2rod = [ybob y2bob];
    set(rod,'xdata',xrod,'ydata',yrod)
    set(bob,'xdata',xbob,'ydata',ybob)
    set(rod2,'xdata',x2rod,'ydata',y2rod)
    set(bob2,'xdata',x2bob,'ydata',y2bob)
    drawnow;
    pause(h);
end
end


function y = EulerStep_pend( x,h )
%one step of the Euler method
z = RHS(x);
y = x+h*z;
end


function y = trapstep_pend( x,h )
%one step of trapezoid method
z1 = RHS(x);
%g = EulerStep(x,h)
g = x+h*z1;
z2 = RHS(g);
y = x+h*(z1+z2)/2;


end

function z = RHS( y )
g = 9.81; length =1;
z(1) = y(2);
z(2) = (-3*g*sin(y(1))-g*(sin(y(1)-2*y(3)))-2*sin((y(1)-y(3)))*((y(4)^2)-(y(2)^2)*cos(y(1)-y(3))))/...
    (3-cos(2*y(1)-2*y(3))) - d*y(2);
z(3) = y(4);
z(4) = 2*sin(y(1)-y(3))*(2*(y(2)^2)+2*g*cos(y(1))+(y(4)^2)*cos(y(1)-y(3)))/...
      (3-cos(2*y(1)-2*y(3)));

end

%Exceute doublepend(0,10,[pi/2 0 pi/2 0],500)