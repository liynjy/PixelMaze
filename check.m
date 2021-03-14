function res = check(maze)
    [N,M] = size(maze);

    if maze(1,1)==1
        res = 0;
        return;
    else
        map = zeros(N,M);
        map(1,1) = 1;
        col = [1,1];
    end

    while size(col,1)>0
        imagesc(map); 
        idx = col(1,:);
        n = idx(1);
        m = idx(2);
        col = col(2:end,:);
        
        if m>1
            if maze(n,m-1)==0 && map(n,m-1)==0
                map(n,m-1)=1;
                col=[col;[n,m-1]];
            end
        end

        if m<M
            if maze(n,m+1)==0 && map(n,m+1)==0
                map(n,m+1)=1;
                col=[col;[n,m+1]];
            end
        end

        if n>1
            if maze(n-1,m)==0 && map(n-1,m)==0
                map(n-1,m)=1;
                col=[col;[n-1,m]];
            end
        end

        if n<N
            if maze(n+1,m)==0 && map(n+1,m)==0 
                map(n+1,m)=1;
                col=[col;[n+1,m]];
            end
        end
    end
    
    res = map(N,M);
end