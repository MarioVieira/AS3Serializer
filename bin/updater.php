<?php
	$content = $_POST['content'];
	$file = $_POST['fileName'];
	$append = $_POST['append'];
	$deleteFile = $_POST['deleteFile'];

	$content = stripslashes($content);

	if($deleteFile == 'true')
	{
		fclose($file);
		unlink($file);
	}
	else if($append == 'false')
	{
		$writeFile = fopen($file, "w");
	}
	else
	{
		$content = "\r\n" . $content;
		$writeFile = fopen($file, "a");
	}

	if(fwrite($writeFile, $content))
	{
		echo $content;

	}
	else
	{
		echo "Error writing to file";
	}

	fclose($writeFile);

?>