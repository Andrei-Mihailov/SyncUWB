Slot = Amp*t0.*exp(-(t0.^2)/(2*alfa));

Chip = Slot(8:13)*10^10;
Slot = Slot*10^10;

Slot = [Slot Slot*0]; %1 нс
Slot = [Slot Slot*0 Slot*0 Slot*0 Slot*0]; % 5 нс
Slot = [Slot Slot*0];                      % 10 нс
% Slot = [Slot Slot*0 Slot*0 Slot*0 Slot*0]; % 25 нс
% Slot = [Slot Slot*0 Slot*0 Slot*0];        % 100 нс

Period = length(Slot); % период между импульсами

Eb = sum(Slot.^2)*dt;

Porog = Eb*Porog_Value;

