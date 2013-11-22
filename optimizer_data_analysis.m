%load data file(s)
%load RAA_Test_Optimization_exp_hinge_record.mat

nDiscard = 9; % Number of reversals to discard from beginning

for i = 1:length(scell)
    for j = 1:2
        scell{i}{j} = staircase('compute', scell{i}{j}, nDiscard);
    end
    staircase('plot', [scell{i}{2}, scell{i}{1}])
    saveas(gcf, num2str(i), 'epsc');
end
close all;