% 4.1 a)
clc, close all, clear all
line = linspace(-2,10,12); %for drawing the straight line
dt = 1;
dudt = @(u) u;

u = zeros(2, 1);
u(1) = 1;
u(2) = u(1)+dt*dudt(1)
t = [0 1];

plot(line, line+1,'b', t, u,'r*'); %plot of the line and first 2 points
xlabel('t');
ylabel('u(t)');

%% b)
clc, close all, clear all
line = linspace(-1,4,7);
dt = 1;
dudt = @(u) u;

u = zeros(3, 1);
u(1) = 1;
for i = 1:2
    u(i+1) = u(i) + dt*dudt(u(i));
end
t = [0 1 2];

hold on
plot(line, line+1,'b'); %line connecting first 2 points
plot(line, 2*line,'b'); %second line connecting 2nd and 3rd point has 2x higher slope 
plot(t, u,'r*');
xlabel('t');
ylabel('u(t)');

%% c)
clc, close all, clear all
line = linspace(-1,4,7);
dt = 1;
dudt = @(u) u;

u = zeros(4, 1);
u(1) = 1;
for i = 1:3
    u(i+1) = u(i) + dt*dudt(u(i));
end
t = [0 1 2 3];

hold on
plot(line, line+1,'b');
plot(line, u(2)*line,'b');
plot(line, u(3)*line-4,'b'); %draw the line connecting 3rd and 4th points
plot(t, u,'r*');
xlabel('t');
ylabel('u(t)');
limits = [-1,4,-1,10]; %limit the plot to relevant area
axis(limits)

%another optional plot that only connects the points without lines
%continuing past the points
figure
hold on
plot([t(1) t(2)],[u(1) u(2)],'b',[t(2) t(3)],[u(2) u(3)],'b',[t(3) t(4)],[u(3) u(4)],'b')
plot(t, u,'r*');
xlabel('t');
ylabel('u(t)');
limits = [-1,4,-1,10];
axis(limits)

%% d
clc, close all, clear all
dt = 1;
dudt = @(u) u;
u_exact = @(t) exp(t); %for plotting exact curve

u = zeros(4, 1);
u(1) = 1;
for i = 1:3
    u(i+1) = u(i) + dt*dudt(u(i));
end
u

t = [0 1 2 3];
time = linspace(0, 3, 50);
u_exact_values = u_exact(time);
plot(time, u_exact_values, 'b', t, u, 'r*'); %plotting exact values and numerical values
xlabel('t');
ylabel('u(t)');