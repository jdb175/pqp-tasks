import sys
import subprocess
import readline

def run_unit_tests(scheme, device_name, configuration):

	print "\nRunning Unit Tests ..."

	unit_test = "xcodebuild test -scheme " + scheme + " -destination name='" + device_name + "' -configuration " + configuration 

	try:
		unit_test_res = subprocess.check_output(unit_test, shell=True, stderr=subprocess.STDOUT,)
	
		#test_start_index = unit_test_res.find("Test Suite")

		#print unit_test_res[test_start_index:]

		return 1

	except subprocess.CalledProcessError as error:
		print "Error: " + error.cmd 
		sys.exit(2)	
		return 0


def main():
	scheme = raw_input("Please enter a scheme: ")

	device_name = raw_input("Please enter a device name: ")

	configuration = raw_input("Please enter a configuration: ")

	run_unit_tests(scheme, device_name, configuration)


if __name__ == "__main__":
	main()