
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code generate shifted results to compare Whitney's results and
% shifted drake's results. This is a for loop to load simulated results. 
% you can run this file directly.
%
% Document Created by: Lin YANG.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;


all_Fx_whitney=[];
all_Fx_drake=[]; 
all_Fz_whitney=[];  
all_Fz_drake=[];
all_L_whitney=[];
all_L_drake=[];


for x_peg = [-0.002:0.0005:-0.0005]


%% load data from Whitney's theory and Drake.  
    
    load(['data_Whitney',mat2str(x_peg),'.mat']);  % load simulated results
    
% align the axis.    
    L = [(z1-0.2) z1 0:0.1:l_21 (l_21):0.1:L_g]
    if length(theta_m) ~= length(L)
        rate=length(theta_m)/length(L);
        theta_m=theta_m(1:rate:end);
    end
    

    file_name=['data_drake',mat2str(x_peg),'.mat'];  % load simulated results
    close all;
    
    
    DRAKE_insertion_d=load(file_name).insertion_d;
    DRAKE_peg=load(file_name).position_peg;
    DRAKE_F_vec=load(file_name).F_vec;

    
    result_60_DRAKE=DRAKE_peg(:,1:3)';
    
    
    
    %% align the insertion axis.

    mm=0.001;
    inseriont_septh=DRAKE_insertion_d/mm;
    inseriont_septh=inseriont_septh-(1.20228+1.01348)
    all_F_w_D=DRAKE_F_vec;
    
    %% align the data length between Drake and Whitney
    type_figure='.pdf';
    
    
    new_Fx_drake=[];new_Fz_drake=[];new_D_drake=[];
    rate=length(all_F_w_D(2,:))/length(Fz); % The data length between Whitney and DRAKE are different
    Fz_drake_short=all_F_w_D(2,1:rate:end);
    Fz_drake_long=all_F_w_D(2,:);
    Fx_drake_short=-all_F_w_D(1,1:rate:end);
    Fx_drake_long=-all_F_w_D(1,:);
    theta_drake_short=result_60_DRAKE(3,1:rate:end);
    Depth_long=inseriont_septh;
    Depth_short=inseriont_septh(1:rate:end);
    id_peak_chanmfer_s=find(Depth_short<=l_21);
    id_peak_chanmfer_w=find(L<=l_21);
    shift_id_w=find(Fz(id_peak_chanmfer_w) == max(Fz(id_peak_chanmfer_w)));
    
    shift_id_z=find(Fz_drake_short(id_peak_chanmfer_s) == max(Fz_drake_short(id_peak_chanmfer_s)));
    delta=1+shift_id_z;
    
    
    shift_value_depth_s=Depth_short(shift_id_z);
    shift_value_depth_w=L(shift_id_w);
    shift_value_depth=shift_value_depth_s-shift_value_depth_w;
    
   
    move_depth_drake=Depth_long-shift_value_depth;
    
 %% align drake's result with Whitney by first force peak.
 
    for oo = 1:length(L)
        this_L=L(oo);
        id_drake_L=find(abs(move_depth_drake-this_L)==min(abs(move_depth_drake-this_L)));
        this_Fz=Fz_drake_long(id_drake_L);
        this_Fx=Fx_drake_long(id_drake_L);
        this_D=Depth_long(id_drake_L);
        new_Fx_drake=[new_Fx_drake this_Fx];
        new_Fz_drake=[new_Fz_drake this_Fz];
        new_D_drake=[new_D_drake this_D];
    end
    

%% plot the results    
    %%
    % *l vs Fx*
    
    handle1=figure,
    plot (L,Fz, 'b'); hold on;
    plot(Depth_short-shift_value_depth,Fz_drake_short,'Color',[0.4660 0.6740 0.1880]); hold on;
    hold on
    chamferline = xline(z1, '--r', {'CFC'});
    chamferline.LabelHorizontalAlignment = 'left';
    pointline1 = xline(0, '--r', {'1PC'});
    pointline2 = xline(l_21, '--r', {'S2PC'});
    pointendline2 = xline(l_2p1 , '--r', {'E2PC'});
    
    all_Fz_whitney=[all_Fz_whitney; Fz;];
    all_Fz_drake=[all_Fz_drake new_Fz_drake];
    
    grid on
    legend('Whitney', 'simulator','Location','east')
    xlabel('Insertion depth (l) [mm]')
    ylabel('Force (Fz) [N]')
    title ([' Insertion Force (Fz) vs Insertion Depth (l) at x = ',mat2str(x_peg)],'interpreter','latex')
    
    name_figure=['Fz_versus_with_depth'];
    exportgraphics(handle1,[name_figure, mat2str(x_peg), type_figure],'BackgroundColor','none','ContentType','vector')
    
    %%
    % *l vs Fz*
    
    handle2=figure,
    plot (L,Fx, 'b'); hold on;
    plot(Depth_short-shift_value_depth,Fx_drake_short,'Color',[0.4660 0.6740 0.1880]); hold on;
    hold on
    
    all_Fx_whitney=[all_Fx_whitney; Fx;];
    all_Fx_drake=[all_Fx_drake new_Fx_drake];
    
    chamferline = xline(z1, '--r', {'CFC'});
    chamferline.LabelHorizontalAlignment = 'left';
    pointline1 = xline(0, '--r', {'1PC'});
    pointline1.LabelHorizontalAlignment = 'right';
%     pointline1.LabelVerticalAlignment = 'middle';
    pointline2 = xline(l_21, '--r', {'S2PC'});
%     pointline2.LabelHorizontalAlignment = 'center';
    pointendline2 = xline(l_2p1 , '--r', {'E2PC'});
%     pointendline2.LabelHorizontalAlignment = 'center';
    grid on
    legend('Whitney', 'simulator', 'Location','east')
    xlabel('Insertion depth (l) [mm]')
    ylabel('Force (Fx) [N]')
    title ([' Insertion Force (Fx) vs Insertion Depth (l) at x = ',mat2str(x_peg)],'interpreter','latex')
    
    name_figure=['Fx_versus_with_depth'];
    exportgraphics(handle2,[name_figure, mat2str(x_peg), type_figure],'BackgroundColor','none','ContentType','vector')
    
    
    %%
    % *theta vs l*    

    
    handle3=figure,
    plot (theta_m,L, 'b'); hold on;
    plot(theta_drake_short,Depth_short-shift_value_depth,'Color',[0.4660 0.6740 0.1880]); hold on;
    hold on
    
    relatve_theta=(theta_m(end)-result_60_DRAKE(3,end))/theta_m(end)
    
    
    all_L_whitney=[all_L_whitney L];
    all_L_drake=[all_L_drake new_D_drake];

    chamferline = yline(z1, '--r', {'CFC'});
    chamferline.LabelVerticalAlignment = 'bottom';
    yline(0, '--r', {'1PC'});
    yline(l_21, '--r', {'S2PC'});
    yline(l_2p1 , '--r', {'E2PC'});
    grid on
    legend('Whitney', 'simulator', 'Location','east')
    xlabel('Insertion Angle (Theta) [rads] ')
    ylabel('Insertion depth (l) [mm]')
    title ([' Insertion Angle vs Insertion Depth at x = ',mat2str(x_peg)],'interpreter','latex')
    
    name_figure=['depth_versus_with_theta'];
    exportgraphics(handle3,[name_figure, mat2str(x_peg), type_figure],'BackgroundColor','none','ContentType','vector')

 
end

%% calculate r

r_Fx=corrcoef(all_Fx_whitney',all_Fx_drake)
r_Fz=corrcoef(all_Fz_whitney',all_Fz_drake)

%% plot Simulated force vs theoretical force

handle_Fx=figure;
for round = 1:length(all_Fx_drake)/453
    start=(round-1)*453+1;
    endd=(round)*453;
    this_Fx_w=all_Fx_whitney(start:endd);
    this_Fx_Drake=all_Fx_drake(start:endd);
    plot(this_Fx_w',this_Fx_Drake,'.'); hold on;
end
grid on
% axis equal
xlim([-2 0])
ylim([-2 0])

legend('x=-0.002 m', 'x=-0.0015 m','x=-0.0010 m','x=-0.0005 m', 'Location','southeast')
xlabel('F_x Whitney [N]')
ylabel('F_x simulated [N]')
title ('Simulated force (Fx) vs theoretical force (Fx)','interpreter','latex')

exportgraphics(handle_Fx,['Fx_vs_Fx.pdf'],'BackgroundColor','none','ContentType','vector')


handle_Fz=figure;
for round = 1:length(all_Fz_drake)/453
    start=(round-1)*453+1;
    endd=(round)*453;
    this_Fz_w=all_Fz_whitney(start:endd);
    this_Fz_Drake=all_Fz_drake(start:endd);
    plot(this_Fz_w',this_Fz_Drake,'.'); hold on;
    %     axis equal;
end
grid on
xlim([0 20])
ylim([0 20])

legend('x=-0.002 m', 'x=-0.0015 m','x=-0.0010 m','x=-0.0005 m', 'Location','northeast')
xlabel('F_z Whitney [N]')
ylabel('F_z simulated [N]')
title ('Simulated force (Fz) vs theoretical force (Fz)','interpreter','latex')

exportgraphics(handle_Fz,['Fz_vs_Fz.pdf'],'BackgroundColor','none','ContentType','vector')

