function res = ShowNum( img )
load Data.mat
v=Main_Process(img,0);
res=MaskRecon(Datas,v);
end

