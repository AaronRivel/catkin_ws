
from quadruped_robot.common_libs import tm as time

class Timer:
    def __init__(self):
        self.start_time = None
        self.elapsed_time = 0
        self.running = False
        
    def reset(self):
        """Resetea el temporizador."""
        self.elapsed_time = 0
        self.start_time = None
        self.running = False

    def start(self):
        """Inicia o reinicia el temporizador."""
        self.start_time = time.time() 
        self.running = True
        
    def config(self,_time):
        self.start_time = time.time() - _time

    def pause(self):
        """Pausa el temporizador, guardando el tiempo transcurrido."""
        if self.running:
            self.elapsed_time = time.time() - self.start_time
            self.running = False

    def resume(self):
        """Reanuda el temporizador."""
        if not self.running:
            self.start_time = time.time() - self.elapsed_time
            self.running = True

    def get_time(self):
        """Devuelve el tiempo transcurrido."""
        if self.running:
            return time.time() - self.start_time
        else:
            return self.elapsed_time
    