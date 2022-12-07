clc, clear all;
frame_list=dir('images/*.jpg');
    
    for i=1:numel(frame_list)
        
        im = imresize(imread( ['./images/' frame_list(i).name] ),[350,600]);
      
        T_Img=Lab_Playfield_Extraction(im);
       
        S_Img=Lab_Svm_Playfield_Extraction(im);

        imwrite(T_Img,['./images/results/' num2str(i) 'T_Img.jpg']);
        imwrite(S_Img,['./images/results/' num2str(i) 'S_Img.jpg']);
    end