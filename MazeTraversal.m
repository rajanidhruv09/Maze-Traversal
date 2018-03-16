global key
InitKeyboard();
state = 0;
timerVal = 0;
while 1
    pause(0.1);
    switch state
        case 0
                distance = brick.UltrasonicDist(1);
                color = brick.ColorColor(4);
                %brick.MoveMotor('BD', 60)
                brick.MoveMotor('B', 63.3)
                brick.MoveMotor('D', 60)
                %disp(state);
                %display(distance);
                if (color == 5)
                    timerVal = tic;
                    state = 9;
                end
                if(distance > 40)
                    state = 3;
                    timerVal = tic;
                end
                %if (distance < 8)
                %    state = 6;
                %end
                %if (distance > 14)
                %    state = 5;
                %    timerVal = tic;
                %end
                if brick.TouchPressed(2)
                    state = 1;
                    timerVal = tic;
                end 
                if (key == 'a')
                    state = 8;
                end
                if (key == 'u')
                    state = 10;
                    timerVal = tic;
                end
                
           
        case 1
            brick.MoveMotor('BD', -60)
            if (toc(timerVal) > 0.5)
                state = 2;
                timerVal = tic;
            end
        case 2
            brick.StopAllMotors();
            brick.MoveMotor('B', -57);
            brick.MoveMotor('D', 60);
            if (toc(timerVal) > 0.383)
                brick.StopAllMotors('Coast');
                state = 0;
            end
        case 3
            brick.StopAllMotors('Brake');
            if (toc(timerVal) > 0.25)
                state = 4;
                timerVal = tic;
            end        
        case 4
            brick.MoveMotor('B', 63.1);
            brick.MoveMotor('D', -60);
            if (toc(timerVal) > 0.383)
                timerVal = tic;
                state = 7;
            end
        %case 5
        %    brick.MoveMotor('B', 62);
        %    brick.MoveMotor('D', 58);
        %    if (toc(timerVal) > 0.25)
        %        state = 0;
        %    end
        %case 6
        %    brick.MoveMotor('B', 58);
        %    brick.MoveMotor('D', 62);
        %    pause(0.25);
        %    state = 0;
        case 7 
            brick.MoveMotor('BD', 60);
            if (toc(timerVal) > 2)
                state = 0;
            end
            
        case 8
            while 1
                pause(0.1);
                switch key
                    case 'uparrow'
                        disp('Forward!');
                        brick.MoveMotor('BD', 400)
            
                    case 'downarrow'
                        disp('Reverse!');
                        brick.MoveMotor('BD', -400)
            
                    case 'leftarrow'
                        disp('Left!');
                        brick.MoveMotor('D', 100)
                        brick.MoveMotor('B', -100)
            
                    case 'rightarrow'
                        disp('Right!');
                        brick.MoveMotor('B', 100)
                        brick.MoveMotor('D', -100)
       
                    case 0 % No key is being pressed.
                        disp('Stop!');
                        brick.StopAllMotors('Brake');
                    case 'm' % Press "q" to quit.
                        state = 0;
                end


            end
        case 9 
            brick.StopAllMotors('Brake');
            if (toc(timerVal) > 0.75)
                state = 0;
            end
        case 10
            brick.MoveMotor('C', 10)
            brick.MoveMotor('C', -300)
            if (toc(timerVal) > 8)
                state = 0;
            end
             
            
    end
    if(key == 'q')
        brick.StopAllMotors();
        break;
    end
end
