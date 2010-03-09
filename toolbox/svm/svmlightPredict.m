function yhat = svmlightPredict(model, X)
% This is a simple interface to svm_light, 
% which must be on the system path. 
%
% model  - model generated by svmFit()
% yhat   - output is in {-1, 1}

% You can use the addtosystempath function to add the directory containing
% svm_classify.exe. 

    X =  mkUnitVariance(center(X));
    testOptions = '-v 3';
    tmp = tempdir();
    testFile    = fullfile(tmp, 'test.svm');
    modelFile   = model.file; 
    logFile     = fullfile(tmp, 'testLog.svm');
    resultsFile = fullfile(tmp, 'results.svm');
    svmlightWriteData(X, zeros(size(X, 1), 1), testFile);
    systemf('svm_classify %s %s %s %s > %s', testOptions, testFile, modelFile, resultsFile, logFile);
    yhat = sign(dlmread(resultsFile));
    if 1
       delete(testFile);
       delete(resultsFile);
       delete(logFile);
    end
end