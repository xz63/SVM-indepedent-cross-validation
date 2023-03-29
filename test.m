% Author: Dr. Xian Zhang from Yale school of medicine, Psychiatry Department
% this program demonstration SVM machine learning for a binary classification
% and prediction of ADOS score for ASD diagnosis using fNIRS data
% please cite our paper "Prediction of  Individual Autism Diagnostic Observation Schedule (ADOS) Scores Based on Neural Responses During Eye-to-Eye Contact Using Support Vector Machine Learning"
if ~exist('ADOS')
load Y
load ADOS
conditionNames={'EyeEye' 'EyeVideo'};
fNIRSsignalNames={'Oxy' 'deOxy' 'Hbdiff'};
nTD=sum(Y==1);
% there are oxy, deoxy and Hbdiff three types of data, we used Hbdiff in our paper
% since SVM training is stochastic, the result may differ from the what in the paper
k=3; %Hbdiff
for c=1:2;
load(sprintf('data/%s/K%d.mat',conditionNames{c},k));
X=resultGLMtopo.Basis';  % the data structure produced by svd program
nFeature=size(X,1);
nSubj=size(X,2);
XdimensionName={'PC' 'Subject'}; % size(X) 30 PCs and 36 subjects
svmobj(c)=SVMCrossValidtionTest(X,sprintf('%s-%s',conditionNames{c},fNIRSsignalNames{k}),...
Y,'Diagnosis', {'TD' 'ASD'});
svmobj(c).train(0); % 1 will use randome labelt to train the model you can try set it to 1 run 1000 times.
end
end
close all

figure
for c=1:2
    for cv=1:2
	p=(c-1)*2+cv;
	subplot(2,4,p);
	a=100*(1-svmobj(c).Error(2:end,cv)); 
	plot(2:nFeature,a,'-o'),
	[b,i]=max(a);
	i=i+1; % because it was searched from 2:end
	t=sprintf('%s %d',svmobj(c).CVName{cv},round(b));
	title(t);
	ylabel(sprintf('Accuracy %s',conditionNames{c})); ylim([30 100]);
	xlabel('nFeature');

	subplot(2,4,p+4);hold on
	for s=1:nSubj
	    score=svmobj(c).Scores(s,i,cv);
	    if score>0
	      color1='b';
	    else
	       color1='r';
	    end
	    if Y(s)==2;
	    h=plot(ADOS(s-nTD),score,'o','MarkerFaceColor',color1); 
	    else
	    h=plot(8+(rand(1)-0.5)/3,score,'h','MarkerFaceColor',color1); 
	    end
	end
	score=svmobj(c).Scores(Y==2,i,cv);
	tt=corrcoef(score,ADOS);
	title(sprintf(' corr= %.2f',tt(2,1)));
	xlabel('ADOS');
	ylabel('SVM Score');
        xlim([6 20]);
        set(gca, 'XTick',[  8:2:18]); % [8
        str=get(gca,'XTickLabel');
        str{1}='TD';
        set(gca,'XTickLabel',str);
        set(gca, 'YTick',[-1:0.4:1]);
    end
end

% conclusion:  k-fold can yield much high scores but poorer correlation between ADOS and score
% the most important: k-fold can yield 81% acuracy for EyeVideo data, but
% that model is poorly related to the ADOS indicating inflated accuracy. indepedent CV yield an honest 53%
% accuracy
