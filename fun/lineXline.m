function pt=lineXline(ln1,ln2)
A=[0 1;-1 0];
V=A*[(ln1(3:4)-ln1(1:2))',(ln2(3:4)-ln2(1:2))'];
pt=[ln1(1:2)*V(:,1),ln2(1:2)*V(:,2)]/V;