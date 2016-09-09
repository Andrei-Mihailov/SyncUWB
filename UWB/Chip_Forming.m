Slot = Amp*t0.*exp(-(t0.^2)/(2*alfa));

Chip = Slot(8:13)*10^10;
Slot = Slot*10^10;

Slot = [Slot Slot*0]; %1 ��
Slot = [Slot Slot*0 Slot*0 Slot*0 Slot*0]; % 5 ��
Slot = [Slot Slot*0];                      % 10 ��
% Slot = [Slot Slot*0 Slot*0 Slot*0 Slot*0]; % 25 ��
% Slot = [Slot Slot*0 Slot*0 Slot*0];        % 100 ��

Period = length(Slot); % ������ ����� ����������

Eb = sum(Slot.^2)*dt;

Porog = Eb*Porog_Value;

