
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code generates plots for section 3.
%
% Document Created by: Lin YANG.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




clear;clc;
load('original_data.mat');
close all;

type_figure='.pdf';
%% plot best robot trajectory among rollouts in each iteration
all_iterations=iter;
list_grey=0.9:(0.1-0.9)/(all_iterations-1):0.1;
list_greys=[list_grey;list_grey;list_grey;];

all_best = figure; copyobj(myfigure,all_best) ;
title('best $$q_R(t)$$ among rollouts in each iteration','interpreter','latex')

for i = 1:all_iterations
    H=plot(all_Z_best(:,2*i-1),all_Z_best(:,2*i),'Color',list_greys(:,i)); hold on
    if i > 1
        if mod(i,5) ~= 0
            set(get(get(H,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        end
    end
end
axis equal
xlim([-0.1 0.1])
ylim([-0.02 0.14])
list_iteration=1:all_iterations;
name_figure=['best_rollout_in_each_iteration_of_q_R'];

grayValues = [list_greys(1,35) list_greys(1,20) list_greys(1,10) list_greys(1,1)];
colorbar('Ticks', grayValues, 'TickLabels', {'Iteration 35','Iteration 20','Iteration 10','Iteration 1'})
colormap('gray'); % Set the colormap to grayscale.

exportgraphics(all_best,[name_figure, type_figure],'BackgroundColor','none','ContentType','vector')

%% plot best peg trajectory among rollouts in each iteration
disp('training finish2')
list_grey=0.9:(0.1-0.9)/(all_iterations-1):0.1;
list_greys=[list_grey;list_grey;list_grey;];

all_best = figure; copyobj(myfigure,all_best) ;
title('best $$q_P(t)$$ among rollouts in each iteration','interpreter','latex')

for i = 1:all_iterations
    H=plot(all_Q_p_best(:,2*i-1),all_Q_p_best(:,2*i),'Color',list_greys(:,i)); hold on
    if i > 1
        if mod(i,5) ~= 0
            set(get(get(H,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        end
    end
end
axis equal
xlim([-0.1 0.1])
ylim([-0.02 0.14])
list_iteration=1:all_iterations;

name_figure=['best_rollout_in_each_iteration_of_q_P'];

grayValues = [list_greys(1,35) list_greys(1,20) list_greys(1,10) list_greys(1,1)];
colorbar('Ticks', grayValues, 'TickLabels', {'Iteration 35','Iteration 20','Iteration 10','Iteration 1'})
colormap('gray'); % Set the colormap to grayscale.

exportgraphics(all_best,[name_figure, type_figure],'BackgroundColor','none','ContentType','vector')

