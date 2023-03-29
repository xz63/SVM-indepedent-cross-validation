classdef SVMCrossValidtionTest <hgsetget
    % This program is made by Dr. Xian Zhang in Psychiatry department 
    % it demonstrate the importance of indepdent feature selection in cross-vailidation 
    % indepdent feature selection: the feature is only selected from the training data
    % in contrast, select feature using the entire data set (K-fold cross-validation)  
    % can not be used for small data set, due to multiple comparison error in neural imaging data
    % please cite our paper "Prediction of  Individual Autism Diagnostic Observation Schedule (ADOS) Scores Based on Neural Responses During Eye-to-Eye Contact Using Support Vector Machine Learning"
    properties
        X
        XName
        Y
        YName
	Labels
	CVName % the name of cross-validation
        Error
	classification
	Scores
    end % end of properties
    methods
        function obj=SVMCrossValidtionTest(X,XName,Y,YName,Labels)
	    obj.X= X;
	    obj.XName= XName;
	    obj.Y= Y;
	    obj.YName= YName;
	    obj.Labels= Labels;
	    obj.CVName={'k-fold' 'indepdent' };
        end
        function train(obj,isScramble)
	    nFeature=size(obj.X,1);
	    for b=2:nFeature
		cv=1;
		[obj.Error(b,cv), obj.classification(:,b,cv),obj.Scores(:,b,cv)]...
		    =LOOsimple(obj.X,obj.Y,b,isScramble); % K-fold, leave one out
		cv=2;
		[obj.Error(b,cv), obj.classification(:,b,cv),obj.Scores(:,b,cv)]...
		    =LOOindependent(obj.X,obj.Y,b,isScramble);
		fprintf('training with %d features\n',b);
	    end
	end
    end
end
