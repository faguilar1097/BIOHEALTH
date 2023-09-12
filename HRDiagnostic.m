function diagnosticoHR = HRDiagnostic(edad, HR)
%% Niñez
diagnostico = [];
if edad <=18
    if HR <=120 && HR> 40,
        diagnostico = 'Heart rate is normal, Status: Resting';
    elseif HR >120 && HR <=220,
        diagnostico = 'Heart rate is slightly elevated, Status: Agitated';
    elseif HR > 220,
        diagnostico = 'High heart rate, Status: Possible tachycardia';
    end        
end
%%Juventud
if edad > 18 && edad<= 30
    if HR <=100 && HR> 40,
        diagnostico = 'Heart rate is normal, Status: Resting';
    elseif HR > 100 && HR <=200,
        diagnostico = 'Heart rate is slightly elevated, Status: Agitated';
    elseif HR > 200
        diagnostico = 'High heart rate, Status: Possible tachycardia';
    end        
end
%% Adultez
if edad > 30 && edad <= 60
    if HR <= 90 && HR> 40,
        diagnostico = 'Heart rate is normal, Status: Resting';
    elseif HR > 90 && HR<=190,
        diagnostico = 'Heart rate is slightly elevated, Status: Agitated';
    elseif HR > 190
        diagnostico = 'High heart rate, Status: Possible tachycardia';
    end        
end
%%Vejez
if edad > 60
    if HR <=90 && HR > 40,
        diagnostico = 'Heart rate is normal, Status: Resting';
    elseif HR > 90 && HR<=160,
        diagnostico = 'Heart rate is slightly elevated, Status: Agitated';
    elseif HR > 160
        diagnostico = 'High heart rate, Status: Possible tachycardia';
    end        
end

if HR <= 40
    diagnostico = 'Heart rate is very low, Status: Possible bradycardia';
end
    

diagnosticoHR = diagnostico;
end