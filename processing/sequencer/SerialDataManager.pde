import java.util.*;
import java.util.concurrent.*;

public class SerialDataManager {
	byte[] serialBytes = new byte[8192];
	ArrayList<Byte> buffer = new ArrayList<Byte>();
	boolean isLocked = false;
	boolean isEnabled = true;

	// Data that comes in from serial, which is placed into the buffer
	public synchronized void readSerial() {
		if (!isEnabled) {
			port.clear();
			return;
		}
		int nBytesAvailable = port.available();

		if (nBytesAvailable > 0) {
		    serialBytes = port.readBytes();

		    for (int i = 0; i < nBytesAvailable; i++) {
		      buffer.add((byte) serialBytes[i]);
		      serialBytes[i] = 0;
		    }
		}
	}

	// Buffer data to be applied to sketch in Processing loop.
	public synchronized void readBuffer() {
		if (!isEnabled) {
			port.clear();
			return;
		}
		boolean found = false;
		byte b0 = 0;
		byte b1 = 0;
		if (buffer.size() > 4) {
			int counter = 0;

			while (!found && counter < 4) {
				b0 = (byte) buffer.get(0);
				b1 = (byte) buffer.get(1);
				if (b0 == (byte) 255 && b1 == (byte) 255) {
					found = true;
				}
				else {
					buffer.remove(0);
				}
			}
		}

		if  (!found) {
			return;
		}

		while (buffer.size() > 4) {
			buffer.remove(0);
			buffer.remove(0);
			byte index = buffer.remove(0);
			byte v0 = buffer.remove(0);
			byte v1 = buffer.remove(0);

			// Digital input bytes
			if (index < 14 && index >= 0) {
				updateByteInput(index, v0);
			}
			// Analog input bytes
			else if (index >= 14 && index < 35) {
				if (frameCount % 5 == 0) {
					updateAnalog(index - 14, ((v0 << 8) & 0xFF00) + (v1 & 0xFF));
				}
			}
		}
	}
}

class SerialDataManagerThread implements Runnable {
	private SerialDataManager serialDataManager;

	SerialDataManagerThread(SerialDataManager serialDataManager) {
		this.serialDataManager = serialDataManager;
	}

	// @Override
	public void run() {
		while(true) {
			synchronized(serialDataManager) {
				serialDataManager.isLocked = true;
				serialDataManager.readSerial();
				serialDataManager.isLocked = false;
			}
		}
	}
}