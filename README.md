# signal_processing

This project aims to develop a MATLAB algorithm to precisely detect the phase of an ongoing EEG rhythm and use the estimate of the current phase to be used to stimulate different regions of the brain at appropriate phase values.
Plan
•	Make readymade data by adding Gaussian noise to sine wave
•	Filter the data with real-time band-pass filter
•	Pass the filtered data through “Hilbert filter” to get real time phase of signal
•	Get the stimulation signal according to the specified values of phase
•	Try the model for a signal with varying frequency


For testing data, a pure sine wave of 10Hz frequency is added white gaussian noise so that it would behave like a real raw EEG data. Now the signal is passed through a Butterworth band pass filter to remove the extra noise and make the data further processable. For this band pas filtering data is fed to the algorithm one sample at a time.
Freq = 10 hz
Sampling rate = 2000 samples/sec


Now the filtered data is passed through “Hilbert Filter” to get the instantaneous phase value. After some hit and trial the Hilbert filter behaved properly when close to 1000 samples were fed. So, to get real time phase at a time stamp, filtered signal value of that time stamp and along with that filtered signal value of previous 999 samples were fed to algorithm and phase at the current time stamp is evaluated. Now we get this plot.
After getting the real time phase, the only task remaining is to evaluate a square wave signal which takes value 1 when the phase value is within some range of specified phase values, else it takes value 0. Later this square wave will be fed to stimulator for stimulating different parts of brain. 
Now there is one problem. There was a phase shift introduced due to the band pass frequency. So, the signal phase values need to be corrected accordingly. For that purpose, frequency response of the band pass filter is calculated corresponding to 10hz signal. Which came out to be close to 7 degrees. So, the phase values were unwrapped then the phase compensation was added and then the phase values were re-wrapped to get the corrected real-time phase value plot. Then the same process was followed to derive a square wave that would direct the stimulator for stimulation for a range of specific phase values.
