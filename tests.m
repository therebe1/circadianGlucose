function testOut = tests
    testOut = functiontests(localfunctions);
end

function testF1Default(testCase)
    const = models.constants;
    G = 10000;
    actSolution = models.funcs.f1(G, const);
    sigSlope = -const.Vg*const.a1; sigMax = const.Rm;
    sigShift = const.C1/const.a1;
    expSolution = models.funcs.sigmoid(G, sigMax, sigSlope, sigShift);
    verifyEqual(testCase,actSolution,expSolution)
end

function testF1Alternative(testCase)
    const = models.constants;
    const.Vg = 5; const.Rm = 100; C1 = -3000;
    G = -10000;
    actSolution = models.funcs.f1(G, const);
    sigSlope = -const.Vg*const.a1; sigMax = const.Rm;
    sigShift = const.C1/const.a1;
    expSolution = models.funcs.sigmoid(G, sigMax, sigSlope, sigShift);
    verifyEqual(testCase,actSolution,expSolution)
end

function testF2Default(testCase)
    const = models.constants;
    G = 10000;
    actSolution = models.funcs.f2(G, const);
    expSolution = const.Ub*(1-exp(-G/(const.C2*const.Vg)));
    verifyEqual(testCase,actSolution,expSolution)
end

function testF2Alternative(testCase)
    const = models.constants;
    const.Vg = 5; const.Ub = 100; C2 = -3000;
    G = -10000;
    actSolution = models.funcs.f2(G, const);
    expSolution = const.Ub*(1-exp(-G/(const.C2*const.Vg)));
    verifyEqual(testCase,actSolution,expSolution)
end

function testF3Default(testCase)
    const = models.constants;
    G = 10000;
    actSolution = models.funcs.f3(G, const);
    expSolution = G/(const.C3*const.Vg);
    verifyEqual(testCase,actSolution,expSolution)
end

function testF3Alternative(testCase)
    const = models.constants;
    const.Vg = 5; C3 = -3000;
    G = 10;
    actSolution = models.funcs.f3(G, const);
    expSolution = G/(const.C3*const.Vg);
    verifyEqual(testCase,actSolution,expSolution)
end

function testBaselineMonotonic(testCase)
    % Find first time e^(-x)+1 is within 1% of 1.
    % Need t_min s.t. 0.99<e^(-t)+1<1.01
    % => t_min = 4.605
    t = 0:0.01:100;
    G = exp(-t)+1;
    funcRes = utils.baseline_return(t, G, 50);
    actSolution = 4.605;
    verifyEqual(testCase,funcRes, actSolution, 'AbsTol', 0.01)
end

function testBaselineMonotonic(testCase)
    % Find first time e^(-x)+1 is within 1% of 1.
    % Need t_min s.t. 0.99<e^(-t)+1<1.01
    % => t_min = 4.605
    t = 0:0.01:100;
    G = exp(-t)sin(0.5t);
    funcRes = utils.baseline_return(t, G, 50);
    actSolution = 4.605;
    verifyEqual(testCase,funcRes, actSolution, 'AbsTol', 0.01)
end