function R = imnoise2(type, varargin)
% This function can generate different kind of noise 'uniform', 'gaussian',
% 'salt & pepper', 'lognormal', 'rayleigh', 'exponential' ,'erlang'

%%Example: r = imnoise2('gaussian', 100000, 1, 0, 1);

%Set defaults
[M, N, a, b] = setDefaults(type, varargin{:});


% Begin processing. Use lower(type) to protecet against input being
% capitalized 
switch lower(type)
    case 'uniform'
        R = a + (b - a)*rand(M, N);
    case 'gaussian'
        R = a + b*randn(M, N);
    case 'salt & pepper'
        R = saltpepper(M, N, a, b);
    case 'lognormal'
        R = exp(b*randn(M, N) + a);
    case 'rayleigh'
        R = a + (-b*log(1 - rand(M, N))).^.5;
    case 'exponential'
        R = exponential(M, N, a);
    case 'erlang'
        R = erlang(M, N, a, b);
    otherwise
        error('Unknown distribution type.')
end 
end


function R = saltpepper(M, N, a, b)
if (a + b) > 1
    error('The sum of Pa + Pb  must not exceed 1.')
end
R(1:M, 1:N) = 0.5;

X = rand(M, N);
R(X <= a) = 0;
u = a+b;
R(X > a & X <= u) = 1;
end

function R = exponential(M, N, a)
if a <= 0
    error('Paramter a must be postive for exponential type.')
end

k = -1/a;
R = k*log(1 - rand(M, N));
end


function R = erlang(M, N ,a ,b)
if (b ~= round(b) || b <= 0)
    error('Parameter b must be a positive integer for Erlang.')
end

k = 1/a;
R = zeros(M, N);
for j = 1:b
    R = R + k*log(1 - rand(M,N));
end
end



function varargout = setDefaults(type, varargin)

varargout = varargin;
P = numel(varargin);

if P <4
    %Set default b.
    varargout{4} = 1;
end

if P < 3
    %Set default a.
    varargout{3} = 0;
end

if P < 2
    %Set default N.
    varargout{2} = 1;
end

if P < 1
    %Set default M.
    varargout{1} = 1;
end

if (P <= 2)
    switch type
        case 'salt & pepper'
            % a = b = 0.05
            varargout{3} = 0.05;
            varargout{4} = 0.05;
        case 'lognormal'
            % a= ; b = 0.25;
            varargout{3} = 1;
            varargout{4} = 0.25;
        case 'exponential'
            % a = 1;
            varargout{3} = 1;
        case 'erlang'
            % a= 2; b = 5;
            varargout{3} = 2;
            varargout{4} = 5;
    end
end

end


