function [C] = Ex_His(S)
% S = 'ADLEDNMETLADLEDNMET';
S_string =(S);
n = length(S);
gs = zeros(1, n + 1);
gs(1) = 0;  % gs(0) = 0 from the paper

gs(2) = 1;  
for n = 2:length(S)
    
    eigenvalue_found = false;
    
   
    idx_list = (gs(n)+1):n;
    for k = 1:ceil(length(idx_list)/2);

        m_upper = idx_list(end - k + 1);
        if ~numel(strfind(S_string(1:(n-1)), S_string(m_upper:n)))
            gs(n+1) = m_upper;    % Remember: 
                                  % gs(n+1) in MATLAB is actually gs(n)
            eigenvalue_found = true;
            break;
        end 
    
        m_lower = idx_list(k);
        if numel(strfind(S_string(1:(n-1)), S_string(m_lower:n)))
            % We've found the eigenvalue!
            gs(n+1) = m_lower-1;    % Remember: 
                                    % gs(n+1) in MATLAB is actually gs(n)
            eigenvalue_found = true;
            break;
        elseif (m_upper == m_lower + 1)
            % If we've made it here, then we know that:
            % - The search for substring S(m,n) from the upper end had a
            %   FOUND result
            % - The search for substring S(m,n) from the lower end had a 
            %   NOT FOUND result
            % - The value of m used in the upper end search is one more
            %   than the value of m used in this lower end search
            %
            % However, when searching from the lower end, we need a FOUND
            % result and then subtract 1 from the corresponding m.
            % The problem with this 'meet-in-the-middle' searching is that
            % it's possible that the actual eigenfunction value actually
            % does occur in the middle, such that the loop would terminate
            % before the lower-end search can reach a FOUND result and the
            % upper-end search can reach a NOT FOUND result.
            %
            % This branch detects precisely this condition, whereby
            % the two searches use adjacent values of m in the middle,
            % the upper-end search has the FOUND result that the lower-end
            % search normally requires, and the lower-end search has the
            % NOT FOUND result that the upper-end search normally requires.
            
            % We've found the eigenvalue!
            gs(n+1) = m_lower;      % Remember: 
                                    % gs(n+1) in MATLAB is actually gs(n)
            eigenvalue_found = true;
            break;
        end
                
    end
    
    if ~eigenvalue_found
        % Raise an error - something is not right!
        error('Internal error: could not find eigenvalue');
    end
    
end

z = length(gs);
hNonzeroLength = 1;

h_i = zeros(1, length(gs));
h_i_length = 1;     % Since h_0 is already present as the first value!


% if strcmpi(type, 'exhaustive')
    
    h_prev = 0;     % Points to h_0 initially
    k = 1;
    while ~isempty(k)
       
        k = find(gs((h_prev+1+1):end) > h_prev, 1); % man khodam gs((h_prev+1+1) be gs(h_prev+1) taghir dadam. chon fek konam eshtebah karde.
        
        if ~isempty(k)
            h_i_length = h_i_length + 1;
            h_prev = h_prev + k;
            h_i(h_i_length) = h_prev;
        end
        hNonzeroLength = hNonzeroLength+1;
    end
    
% end;
  h_i(hNonzeroLength:end) = [];
 
if h_i(1,end) < z
    H = cell([1 (hNonzeroLength-1)]);
    for k = 1:(hNonzeroLength-1-1)
        H{k} = S((h_i(k)+1):h_i(k+1));
    end
    H{hNonzeroLength-1} = S(h_i(k+1)+1:(end));
else
    H = cell([1 (hNonzeroLength-1-1)]); %chon moghei ke akharin component history exhustive bashe, yek khooneh dar H ezafi miad.
    for k = 1:(hNonzeroLength-1)
        H{k} = S((h_i(k)+1):h_i(k+1));
    end
end;

% Theorem 8 - check that gs(h_m - 1) <= h_m-1
if gs(h_i(h_i_length) - 1 + 1) > h_i(h_i_length-1)
    error(['Check failed for exhaustive sequence: ' ...
        'Require: gs(h_m - 1) <= h_m-1']);
end

C = length(H);
% C = length(H) / (n / log2(n))

    