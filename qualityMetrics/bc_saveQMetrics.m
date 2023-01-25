function bc_saveQMetrics(param, qMetric, forGUI, savePath)
% JF, Save quality metrics
% ------
% Inputs
% ------
% 
% ------
% Outputs
% ------
if ~exist(savePath, 'dir')
    mkdir(fullfile(savePath))
end

% save parameters
parquetwrite([fullfile(savePath, '_bc_parameters._bc_qMetrics.parquet')], struct2table(param))

% save quality metrics 
if param.saveMatFileForGUI
    save(fullfile(savePath, 'templates.qualityMetricDetailsforGUI.mat'), 'forGUI', '-v7.3')
end

% save fraction refractory period violations for all different tauR times 
parquetwrite([fullfile(savePath, 'templates._bc_fractionRefractoryPeriodViolationsPerTauR.parquet')],array2table(qMetric.fractionRPVs))
qMetric.fractionRPVs_estimatedTauR = qMetric.fractionRPVs(qMetric.RPV_tauR_estimate);
qMetric = rmfield(qMetric, 'fractionRPVs');

% save the rest of quality metrics and fraction refractory period
% violations for each unit's estimated tauR
qMetricArray = squeeze(reshape(table2array(struct2table(qMetric, 'AsArray', true)), size(qMetric.maxChannels,2),...
    length(fieldnames(qMetric))));
qMetricTable = array2table(qMetricArray);
qMetricTable.Properties.VariableNames =  fieldnames(qMetric);

parquetwrite([fullfile(savePath, 'templates._bc_qMetrics.parquet')], qMetricTable)


end