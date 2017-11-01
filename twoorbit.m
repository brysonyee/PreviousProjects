function  orbit( a,b,ic,n,p )
%a is the initial time
%b is the terminal time
%ic is a column vector - a 8x1 vector with 
%                 ic(1,1) the x1 position
%                 ic(2,1) the x1 component of velocity
%                 ic(3,1) the y1 position
%                 ic(4,1) the y1 component of velocity
%                 ic(5,1) the x2 position
%                 ic(6,1) the x2 component of velocity
%                 ic(7,1) the y2 position
%                 ic(8,1) the y2 component of velocity
%n is the number of timesteps
%p represents the number of time steps between plots
h = (b-a)/n;
y(:,1) = ic;
t(1)=a;
set(gca,'xlim',[-5 5],'ylim',[-5 5],'XTick',[-5 0 5],'YTick',...
    [-5 0 5], 'Drawmode','fast','Visible','on','NextPlot','add');
cla;
axis square
head1= line('color','r','Marker','.','markersize',25, 'erase','xor',...
    'xdata',[],'ydata',[]);
tail1= line('color','b','LineStyle','-', 'erase','none',...
    'xdata',[],'ydata',[]);
head2=line('color','b','Marker','.','markersize',30,...
  'erase','xor','xdata',[],'ydata',[]);
tail2=line('color','r','LineStyle','-','erase','none',...
  'xdata',[],'ydata',[]);
%%%%
%
%Insert 1-step method code here.
%
%%%
for k=1:n/p
    for j=1:p
    t(j+1) = t(j) +h;
    y(:,j+1) = EulerStep_orb(y(:,j),h);
    %y(:,j+1) = trapstep_orb(y(:,j),h);
    end
    y(:,1) = y(:,p+1);
    t(1) = t(p+1);
        %x and y coordinates of the satellite
    set(head1,'xdata',y(1,1),'ydata',y(3,1));
    set(tail1,'xdata',y(1,2:p),'ydata',y(3,2:p));
    set(head2,'xdata',y(5,1),'ydata',y(7,1));
    set(tail2,'xdata',y(5,2:p),'ydata',y(7,2:p));
    drawnow;pause(h)
end
end


function y = EulerStep_orb( x,h )
%one step of the Euler method
z = RHS_orb(x);
y = x+h*z;
end


function y = trapstep_orb( x,h )
%one step of trapezoid method
z1 = RHS_orb(x);
g = x+h*z1;
z2 = RHS(g);
y = x+h*(z1+z2)/2;
end

function z = RHS_orb( y )
%The right hand side of the one-body problem
%y is the 8x1 column vector containing
%          horz. position, horz. velocity, vert. position, vert. velocity
%          (x2)
m2=.3;
m1=.03;
g=1;
mg1=m1*g;
mg2=m2*g;
px1=y(1); vx1=y(2); py1=y(3); vy1=y(4);
px2=y(5); vx2=y(6); py2=y(7); vy2=y(8);
dist=sqrt((px2-y(1))^2+(py2 -y(3))^2);
z = zeros(8,1);
z(1) = y(2);
z(2) = (mg2*(px2-y(1)))/(dist^3);
z(3) = y(4);
z(4) = (mg2*(py2-y(3)))/(dist^3);
z(5)=y(6);
z(6)=(mg1*(px1-px2))/(dist^3);
z(7)=y(8);
z(8)=(mg1*(py1-py2))/(dist^3);
end

% Execute orbit(0,100, [0 1 2 0],10000,5)



