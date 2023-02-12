clear;

load('CoastlineData.mat');

%Task1.1
xEast = xEast/1000; %convert to km
yNorth = yNorth/1000; %convert to km

%Task1.2
figure('Name', 'Coast inflection points');
scatter(xEast, yNorth);

daspect([1 1 1]);

axis([-50 350 -50 450]); %xmin xmax ymin ymax

xticks([0, 100, 200, 300]);
yticks([0, 100, 200, 300, 400]);

xticklabels({'0 datum','100km','200km','300km'});
yticklabels({'0 datum', '100km','200km','300km','400km'});

xlabel('Kilometres east of datum')
ylabel('Kilometres north of datum')

%Task1.3
figure('Name', 'Coast Outline');
plot(xEast, yNorth, 'k');

daspect([1 1 1]);

axis([-50 350 -50 450]); %xmin xmax ymin ymax

xticks([0, 100, 200, 300]);
yticks([0, 100, 200, 300, 400]);

xticklabels({'0 datum','100km','200km','300km'});
yticklabels({'0 datum', '100km','200km','300km','400km'});

xlabel('Kilometres east of datum')
ylabel('Kilometres north of datum')

%Task1.4
figure('Name', 'Emerald Isle');
patch(xEast, yNorth, 'g');

daspect([1 1 1]);

axis([-50 350 -50 450]); %xmin xmax ymin ymax

xticks([0, 100, 200, 300]);
yticks([0, 100, 200, 300, 400]);

xticklabels({'0 datum','100km','200km','300km'});
yticklabels({'0 datum', '100km','200km','300km','400km'});

xlabel('Kilometres east of datum')
ylabel('Kilometres north of datum')


%Task2.1
%%polyin = polyshape({xEast}, {yNorth});
%%[xcent,ycent] = centroid(polyin);
xcent= mean(xEast);
ycent= mean(yNorth);

%Task2.2
figure('Name', 'Centoid of Ireland, with largest possible circle');
plot(xEast, yNorth, 'k');
hold on
scatter(xcent, ycent, 'filled', 'r');
text(xcent, ycent, '\leftarrowCentorid','Color','blue','FontSize',14);

daspect([1 1 1]);

axis([-50 350 -50 450]); %xmin xmax ymin ymax

xticks([0, 100, 200, 300]);
yticks([0, 100, 200, 300, 400]);

xticklabels({'0 datum','100km','200km','300km'});
yticklabels({'0 datum', '100km','200km','300km','400km'});

xlabel('Kilometres east of datum')
ylabel('Kilometres north of datum')

%Task2.3
cent = [xcent ycent];
min_d= 9000;
dist_array = zeros(93,1);
for i= 1:93
   refpointx = xEast(i,1);
   refpointy = yNorth(i,1);
   refpoint = [refpointx refpointy];
   distance = norm(refpoint- cent);
   dist_array(i) = distance;
   if distance < min_d
       min_d= distance;
   end
end
disp(min_d);
% Above finds the maximum possible radius and recording distances into an
% array for task 2.5

%Task2.4
viscircles(cent, min_d);

%Task2.5
figure('Name', 'Coast inflection points with coloured distance');
colormap(parula(7));
scatter(xEast, yNorth, [], dist_array, 'filled');

daspect([1 1 1]);

axis([-50 350 -50 450]); %xmin xmax ymin ymax

xticks([0, 100, 200, 300]);
yticks([0, 100, 200, 300, 400]);

xticklabels({'0 datum','100km','200km','300km'});
yticklabels({'0 datum', '100km','200km','300km','400km'});

xlabel('Kilometres east of datum')
ylabel('Kilometres north of datum')

%Task2.6
%%polyin = polyshape({xEast}, {yNorth});
%%P = perimeter(polyin);%% calculates perimeter
perimeter = 0;
for i = 2:93   %% Works as last and first points are the same point
   refpointx = xEast(i-1,1);
   refpointy = yNorth(i-1,1);
   refpoint = [refpointx refpointy];
   refpointx2 = xEast(i,1);
   refpointy2 = yNorth(i,1);
   refpoint2 = [refpointx2 refpointy2];    
   pointdist = norm(refpoint2 - refpoint);
   perimeter = perimeter + pointdist;
end
disp(perimeter);

%Task3.1
co_ordinates = [xEast yNorth];%Creating co-ordinate matrix
longline = max(pdist(co_ordinates));%Finding largest distance between two co-ordinates

figure('Name', 'Emerald Isle with longest line');
patch(xEast, yNorth, 'g');
line([47.08, 280.6], [0.2177, 423.8], 'Color', 'k');%Points found by looking at data
text((47.08+280.8)/2, (0.2177+423.8)/2, '\leftarrowLongest Line','Color','k','FontSize',14);

daspect([1 1 1]);

axis([-50 350 -50 450]); %xmin xmax ymin ymax

xticks([0, 100, 200, 300]);
yticks([0, 100, 200, 300, 400]);

xticklabels({'0 datum','100km','200km','300km'});
yticklabels({'0 datum', '100km','200km','300km','400km'});

xlabel('Kilometres east of datum')
ylabel('Kilometres north of datum')

%Task3.2
north_e = 0;
north_w = 0;
south_w = 0;
south_e = 0;
figure('Name', 'NSEW Scatter colour plot');

for i = 1:93
    refpointx = xEast(i,1);
    refpointy = yNorth(i,1);
    hold all
    if (refpointx > xcent)&&(refpointy > ycent)
       scatter(refpointx, refpointy, 'filled', 'r');
       north_e = north_e + 1;
    
    elseif (refpointx < xcent)&&(refpointy > ycent)
        scatter(refpointx, refpointy, 'filled', 'b');
        north_w = north_w + 1;
     
    elseif (refpointx < xcent)&&(refpointy < ycent)
        scatter(refpointx, refpointy, 'filled', 'k');
        south_w = south_w + 1;
          
    else
        scatter(refpointx, refpointy, 'filled', 'g');
        south_e = south_e + 1;
        
    end
end
hold off
daspect([1 1 1]);

axis([-50 350 -50 450]); %xmin xmax ymin ymax

xticks([0, 100, 200, 300]);
yticks([0, 100, 200, 300, 400]);

xticklabels({'0 datum','100km','200km','300km'});
yticklabels({'0 datum', '100km','200km','300km','400km'});

xlabel('Kilometres east of datum');
ylabel('Kilometres north of datum');

%Task3.3
figure('Name', 'NSEW inflecton bar Chart');
xoxo = categorical({'North East', 'North West', 'South West', 'South East'});
xoxo = reordercats(xoxo,{'North East', 'North West', 'South West', 'South East'});
yoyo = [north_e north_w south_w south_e];
bar(xoxo, yoyo, 'FaceColor',[0 .1 .5],'EdgeColor',[0 .9 .1],'LineWidth',1.5);

%Task3.4
figure('Name', 'Red rectangle around Ireland');
patch(xEast, yNorth, 'g');

xs = min(xEast);
xline(xs, 'r', 'LineWidth', 2);

xl = max(xEast);
xline(xl, 'r', 'LineWidth', 2);

ys = min(yNorth);
yline(ys, 'r', 'LineWidth', 2);

yl = max(yNorth);
yline(yl, 'r', 'LineWidth', 2);

daspect([1 1 1]);

axis([-50 350 -50 450]); %xmin xmax ymin ymax

xticks([0, 100, 200, 300]);
yticks([0, 100, 200, 300, 400]);

xticklabels({'0 datum','100km','200km','300km'});
yticklabels({'0 datum', '100km','200km','300km','400km'});

xlabel('Kilometres east of datum');
ylabel('Kilometres north of datum');

%Task3.5
figure('Name', 'Sailing route around Ireland');
route = convhull(xEast, yNorth);
patch(xEast, yNorth, 'g');
hold on
plot(xEast(route), yNorth(route),'r', 'LineWidth', 2);
[route] = convhull(xEast, yNorth);
distancetravelled = sum(route);
disp(distancetravelled);

daspect([1 1 1]);

axis([-50 350 -50 450]); %xmin xmax ymin ymax

xticks([0, 100, 200, 300]);
yticks([0, 100, 200, 300, 400]);

xticklabels({'0 datum','100km','200km','300km'});
yticklabels({'0 datum', '100km','200km','300km','400km'});

xlabel('Kilometres east of datum');
ylabel('Kilometres north of datum');