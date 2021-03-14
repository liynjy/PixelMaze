% Author: Lin Junyang
% Maze Gen V1.0
%
% MATLAB

%%
clear all; close all; clc; tc_fail = false;
fprintf("Generating maze. Please wait ...\n")

M = randi(40)+5;
N = randi(40)+5;
K = floor((N*M-1)/2);
    
%%
fig = figure;
colormap(flag)
cnt = 0;
global maze maze_ex img x y M N

while 1
    while 1
        maze = rand(N, M);
        maze(maze<0.1) = 0;
        maze(maze>0) = 1;
        maze(1,1) = 0;
        maze(N,M) = 0;

        while sum(sum(maze))>K
            maze = maze.*rand(N, M);
            maze(maze<0.0005) = 0;
            maze(maze>0) = 1;
            maze(1,1) = 0;
            maze(N,M) = 0;
        end


        img = ones(N+2,M+2)*2;
        img(2:end-1,2:end-1) = maze;
        if maze(1,1)==0
            img(2,2) = -10;
        end
        if maze(N,M)==0
            img(N+1,M+1) = -10;
        end
        imagesc(img)
        pause(0.1)

        if check(maze) && sum(sum(maze))>M*N/4
            break;
        end

        K = floor(K*0.99-10);
        if K < floor((N*M-1)/3)
            K = floor((N*M-1)/3);
        end
        fprintf(".")
        cnt=cnt+1;
        if mod(cnt,79)==0
            fprintf("\n")
        end
    end

    maze_ex = ones(N+2,M+2);
    maze_ex(2:end-1,2:end-1) = maze;

    cnt = 0;
    while cnt<M*N*10
        mm = randi(M)+1;
        nn = randi(N)+1;

        ss = sum(sum(maze_ex(nn-1:nn+1,mm-1:mm+1)));
        if ss<2 || (ss<3 && rand<0.02)
            maze_ex(nn,mm) = 1; 
            maze(nn-1,mm-1) = 1; 
        end

        cnt = cnt+1;
    end
    
	if check(maze)
        break
    end
end

img = ones(N+2,M+2)*2;
img(2:end-1,2:end-1) = maze;
if maze(1,1)==0
    img(2,2) = -10;
end
if maze(N,M)==0
    img(N+1,M+1) = -10;
end
imagesc(img)
title('PRESS [  \uparrow  \downarrow  \leftarrow \rightarrow ] to MOVE')
xlabel('PRESS: [r] RESTART, [n] NEW, [x] EXIT GAME')

fprintf("\n")
disp("Ready.")


%%
x=2;
y=2;


set(fig,'windowkeypressfcn',@keypressfcn);
set(fig,'windowkeyreleasefcn',@keyreleasefcn);

function keypressfcn(h,evt)
    global maze maze_ex img x y M N
    k = evt.Key;
    
    if strcmp(k,'x') || strcmp(k,'X')
        close all
    end
    
    if strcmp(k,'r') || strcmp(k,'R')
        x=2;
        y=2;
        img = ones(N+2,M+2)*2;
        img(2:end-1,2:end-1) = maze;
        if maze(1,1)==0
            img(2,2) = -10;
        end
        if maze(N,M)==0
            img(N+1,M+1) = -10;
        end
        imagesc(img)
        title('PRESS [  \uparrow  \downarrow  \leftarrow \rightarrow ] to MOVE')
        xlabel('PRESS: [r] RESTART, [n] NEW, [x] EXIT GAME')
    end
    
    if strcmp(k,'n') || strcmp(k,'N')
        maze_gen
    end
    
    if x==M+1 && y==N+1
        return
    end
    
    if strcmp(k,'uparrow')
        if maze_ex(y-1,x)==0
            img(y,x)=0;
            img(y-1,x)=-10;
            imagesc(img)
            title('PRESS [  \uparrow  \downarrow  \leftarrow \rightarrow ] to MOVE')
            xlabel('PRESS: [r] RESTART, [n] NEW, [x] EXIT GAME')
            y=y-1;
        end
    end
    
    if strcmp(k,'downarrow')
        if maze_ex(y+1,x)==0
            img(y,x)=0;
            img(y+1,x)=-10;
            imagesc(img)
            title('PRESS [  \uparrow  \downarrow  \leftarrow \rightarrow ] to MOVE')
            xlabel('PRESS: [r] RESTART, [n] NEW, [x] EXIT GAME')
            y=y+1;
        end
    end
    
    if strcmp(k,'leftarrow')
        if maze_ex(y,x-1)==0
            img(y,x)=0;
            img(y,x-1)=-10;
            imagesc(img)
            title('PRESS [  \uparrow  \downarrow  \leftarrow \rightarrow ] to MOVE')
            xlabel('PRESS: [r] RESTART, [n] NEW, [x] EXIT GAME')
            x=x-1;
        end
    end
    
    if strcmp(k,'rightarrow')
        if maze_ex(y,x+1)==0
            img(y,x)=0;
            img(y,x+1)=-10;
            imagesc(img)
            title('PRESS [  \uparrow  \downarrow  \leftarrow \rightarrow ] to MOVE')
            xlabel('PRESS: [r] RESTART, [n] NEW, [x] EXIT GAME')
            x=x+1;
        end
    end
    
    if x==M+1 && y==N+1
        title('==================== YOU WIN ====================','color','r')
        xlabel('PRESS: [r] RESTART, [n] NEW, [x] EXIT GAME')
    end
end

function keyreleasefcn(h,evt)
   %
end

