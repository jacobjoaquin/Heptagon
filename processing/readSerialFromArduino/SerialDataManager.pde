import java.util.*;
import java.util.concurrent.*;

public class SerialDataManager {
	byte[] serialBytes = new byte[1024];
	ArrayList<Byte> buffer = new ArrayList<Byte>();

	// Data that comes in from serial, which is placed into the buffer
	public synchronized void readSerial() {
		// println("readSerial()");
		int nBytesAvailable = port.available();
	  
		if (nBytesAvailable > 0) {
		    serialBytes = port.readBytes();

		    for (int i = 0; i < nBytesAvailable; i++) {
		      buffer.add((byte) serialBytes[i]);
		      serialBytes[i] = 0;
		    }
		}

		// println(buffer);
	}

	// Buffer data to be applied to sketch in Processing loop.
	public synchronized void readBuffer() {
		while (buffer.size() > 1) {
	      byte index = buffer.remove(0);
	      byte value = buffer.remove(0);
	      Chip c = chips.get(index);
	      c.pins = value;
		}
	}
}

class SerialDataManagerThread implements Runnable {
	private SerialDataManager serialDataManager;

	SerialDataManagerThread(SerialDataManager serialDataManager) {
		this.serialDataManager = serialDataManager;
	}

	@Override
	public void run() {
		while(true) {
			synchronized(serialDataManager) {
				serialDataManager.readSerial();
			}
		}
	}
}