targets = load('/Users/apple/Desktop/CV/SIFTMatching/scores/targets.txt');
outputs = load('/Users/apple/Desktop/CV/SIFTMatching/scores/Scores.txt');
targets = targets';
outputs = outputs';
plotroc(targets, outputs, 'SIFT');
[tpr,fpr,thresholds] = roc(targets,outputs);