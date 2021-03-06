% Matlab Implementation for Case Study Two on paper:
% W. Ruan, M. Wu, Y. Sun, X. Huang, D. Kroening and M. Kwiatkowska,
% Global Robustness Evaluation of Deep Neural Networks with Provable
% Guarantees for L0 Norm, arXiv:1804.05805. April 2018.
% -- Dr. Wenjie Ruan, 14 May 2018
%% This is for model "DNN4"

clear
load DNN4
layer = 'fc_2';
convnet = convnet1;

maxIter = 2;
delta = floor(1/0.5);
allResult = [];

resultIndex = 1;

for index_test_image = 1:1000
    t = 1;
    test_image = XTest(:,:,:,index_test_image);
    [size_row, size_col, size_chl] = size(test_image);
    f0_all = activations(convnet,test_image,layer,'OutputAs','rows');
    [f0,index_f0] = max(f0_all);
    L = [];
    U = [];
    Uc = [];
    Ur = [];
    image_upperbound = {};
    
    while(t<=maxIter)
        fprintf('\n----------------------------Iteration t = %d ----------------------------\n',t)
        subspace_set = nchoosek(1:size_row*size_col,t);
        fprintf('\nNow calculate the sensitivity subset list at t = %d > > >\n', t );
        tStart = tic;
        [sens_set] = GenerateSensitivitySetParal(test_image,convnet,layer,...
            f0,index_f0,delta,t,subspace_set,size_row,size_col);
        tElapsed = toc(tStart);
        sens_set_sort = sortrows(sens_set,t+1,'descend');
        
        %%
        if sens_set_sort(:,end) ==1
            fprintf('\n > > > Lower Bound of Maximum Radius of Safe L0-Norm Ball: L = %d\n\n',t);
        else
            d_m =t;
            L(t) = t;
            U(t) = t;
            Uc(t) = (L(t)+U(t))/2;
            Ur(t) = (U(t)-L(t))/2;
            fprintf('\n > > > Convergent at t = %d ! Maximum Radius of Safe L0-Norm Ball is found: d_m = %d\n\n',t, d_m);
            break;
        end
        
        %% Generate Upper Bound
        disp('Now Calculate Upper Bound of Maximum Radius of Safe L0-Norm Ball  > > > ')
        [test_image_adv,pixel_modify,val_modify,~,adv_dis,succ_flag] = GenerateUpperBound(test_image,convnet,...
            layer, sens_set_sort,index_f0,t);
        if succ_flag == 1
            fprintf('\n > > > Initial Upper Bound of Maximum Radius of Safe L0-Norm Ball: U_i = %d \n\n',adv_dis);
        else
            break;
        end
        
        %% Tighten Upper Bound
        disp('Now Tighten Upper Bound of Maximum Radius of Safe L0-Norm Ball > > > ')
        
        [test_image_adv,pixel_modify,f_label,adv_dis,succ_flag] = TightenUpperBound(test_image,test_image_adv,convnet,...
            layer, pixel_modify,val_modify,index_f0);
        
        L(t) = t;
        U(t) = adv_dis;
        Uc(t) = (L(t)+U(t))/2;
        Ur(t) = (U(t)-L(t))/2;
        image_upperbound{t} = test_image_adv;
        
        if t == 1
            fprintf('\n > > > Tight Upper Bound of Maximum Radius of Safe L0-Norm Ball: U_tighten = %d \n',adv_dis);
        end
        
        if t >1
            if U(t) > U(t-1)
                L(t) = L(t-1);
                U(t) = U(t-1);
                Uc(t) = Uc(t-1);
                Ur(t) = Ur(t-1);
                image_upperbound{t} = image_upperbound{t-1};
            end
            fprintf('\n > > > Tight Upper Bound of Maximum Radius of Safe L0-Norm Ball: U_tighten = %d \n',U(t));
        end
        
        if Ur(t)<=1
            d_m =U(t);
            fprintf('\n > > > Convergent at t = %d ! Maximum Radius of Safe L0-Norm Ball is found: d_m = %d\n',t, d_m);
            break;
        else
            d_m =NaN;
            fprintf('\n > > > Not Convergent at t = %d ! The Anytime Robustness is: (%4.1f , %4.1f) \n',t,Uc(t),Ur(t));
        end
        t = t+1;
    end
    allResult(resultIndex,:) = [resultIndex,Uc(end),Ur(end),L(end),U(end)];
    resultIndex = resultIndex + 1;
end

globalAnytimeRobustness = [mean(allResult(:,2)), mean(allResult(:,3))];

fprintf('\n The Anytime Global Robustness is: (%4.1f , %4.1f) \n',globalAnytimeRobustness(1),globalAnytimeRobustness(2));


