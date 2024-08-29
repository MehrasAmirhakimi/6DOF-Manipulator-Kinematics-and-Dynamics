clc;
clear all;%#ok
while(1)
    O=1;
    disp('Hello Ueser ,This is full version of manipulator simulation')
    disp('please insert type of your optimization betven min and max')
    disp('please insert type of your optimization betven min and max')
    SelectType=input('','s');
    switch SelectType
        case 'min'
            Op=0;
        case 'max'
            Op=1;
        otherwise
            disp('Erorr')
            disp('Invalid Input!')
            disp('Please Try Again')
            O=0;
    end
    if O~=0
        break;
    end
end