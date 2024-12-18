%% SimularUAVMision.m 
% Proporciona una simulación visual de una misión UAV, mostrando cómo el 
% UAV sigue la trayectoria especificada y permite visualizar su posición
% y orientación en un entorno 3D.
% Funcion para crear una tabla de posiciones y rotaciones proporcionada
% como entrada al dron, marcando su trayectoria. 
% Toma los waypoints en la trayectora y asume un altitud fija del dron
% Entradas
% m                     Mision del UAV
% referenceLocation     Ubicacion de referencia
% Tsim                  Tiempo de Simulacion (opcional, si no se especifica se ajusta a traj.EndTime)
function SimularUAVMision(m,referenceLocation,TSim)
% Crea una nueva figura
figure
% Muestra la mision con la ubicacion de refencia proporcionada
show(m,ReferenceLocation=referenceLocation);
grid on
% Configurar el parser de mision
parser = multirotorMissionParser(TakeoffSpeed=5,TransitionRadius=0.5);
traj = parse(parser,m,referenceLocation);
hold on
show(traj);
title("Espacio de cobertua de la Mision")

%%
% Crear un escenario UAV
s = uavScenario(ReferenceLocation=referenceLocation,UpdateRate=1);
% Crear un nuevo escenario con la ubicacion de referencia
plat = uavPlatform("UAV",s);
% actualiza la malla del UAV a un quadrotor y una transformacion inicial
% especificada por la matriz de transformacion eul2tform()
%
plat.updateMesh("quadrotor",{60},[1 0 0],eul2tform([0 0 pi]));


%% Simular la trayectoria
ax = s.show3D();
s.setup();
if(nargin<3)
    TSim=traj.EndTime;
end
counter=0;
while s.CurrentTime <= TSim
    plat.move(traj.query(s.CurrentTime));
    %Limit render rate.
    counter=counter+1;
    if(mod(counter,100)==0)
        s.show3D(Parent=ax,FastUpdate=true);
        s.advance();
        pause(0.001);
        drawnow;
    end
end

%%
% Crear un vector de tiempos
ts = linspace(traj.StartTime,TSim,50);
% Obtiene las posiciones y orientaciones del UAV en el tiempo ts
motions = query(traj,ts);
ts = seconds(ts);
position = motions(:,1:3);
position = position(:,[2 1 3]);
position(:,3) = -position(:,3);
orientation = motions(:,10:13);
angles = zeros(size(orientation,1),3);
for idx = 1:size(orientation,1)
    rotm = quat2rotm(orientation(idx,:));
    rotm = eul2rotm([pi/2 0 pi])*rotm*eul2rotm([0 0 pi]);
    angles(idx,:) = rotm2eul(rotm);
end
end