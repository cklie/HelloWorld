echo off
tasklist | find /i "QDA.exe" && taskkill /im QDA.exe /F || echo Process "QDA.exe" not running.

::----------------------------------------------------
set vCur=T20\v0
set vM18=M18\v3
set vM15=M15\v15
set vM12=M12\v24
set vM09=M9\v24
set vM06=M6\v21
set vM03=M3\v21
::----------------------------------------------------


echo Setzten der Quell- und Zielverzeichnisse...
set EXIA=\\EXIA\Liefer\Liefer900\Alle Versionen\QDA
set CKLIE=C:\Program Files (x86)\ASI DataMyte\QDA9


echo Kopiervorgang der QDA.exe...
echo R9T20: & copy "%EXIA%\QDA9.R9T20v0Kandidat\QDA.exe" "%CKLIE%\%vCur%\Bin\QDA.exe" /y & copy "%CKLIE%\Alias.ini" "%CKLIE%\%vCur%\Data\Alias.ini" /y
echo R9M18: & copy "%EXIA%\QDA9.R9M18v3Development\QDA.exe" "%CKLIE%\%vM18%\Bin\QDA.exe" /y & copy "%CKLIE%\Alias.ini" "%CKLIE%\%vM18%\Data\Alias.ini" /y
echo R9M18: & copy "%EXIA%\QDA9.R9M18v3Kandidat\QDA.exe" "%CKLIE%\%vM18%\Bin\QDA_QS.exe" /y
echo R9M15: & copy "%EXIA%\QDA9.R9M15v15Development\QDA.exe" "%CKLIE%\%vM15%\Bin\QDA.exe" /y & copy "%CKLIE%\Alias.ini" "%CKLIE%\%vM15%\Data\Alias.ini" /y
echo R9M15: & copy "%EXIA%\QDA9.R9M15v15Kandidat\QDA.exe" "%CKLIE%\%vM15%\Bin\QDA_QS.exe" /y 
echo R9M12: & copy "%EXIA%\QDA9.R9M12v24Kandidat\QDA.exe" "%CKLIE%\%vM12%\Bin\QDA.exe" /y & copy "%CKLIE%\Alias.ini" "%CKLIE%\%vM12%\Data\Alias.ini" /y
echo R9M9:  & copy "%EXIA%\QDA9.R9M9v24Kandidat\QDA.exe" "%CKLIE%\%vM09%\Bin\QDA.exe" /y & copy "%CKLIE%\Alias.ini" "%CKLIE%\%vM09%\Data\Alias.ini" /y
echo R9M6:  & copy "%EXIA%\QDA9.R9M6v21Kandidat\QDA.exe" "%CKLIE%\%vM06%\Bin\QDA.exe" /y & copy "%CKLIE%\Alias.ini" "%CKLIE%\%vM06%\Data\Alias.ini" /y
echo R9M3:  & copy "%EXIA%\QDA9.R9M3v21Kandidat\QDA.exe" "%CKLIE%\%vM03%\Bin\QDA.exe" /y & copy "%CKLIE%\Alias.ini" "%CKLIE%\%vM03%\Data\Alias.ini" /y


echo Shortcuts erneuern...
del "C:\Users\cklie.ASIDATAMYTE\Desktop\QDA*.lnk"
echo R9T20: & "C:\Program Files (x86)\ShortCut\shortcut.exe" /F:"C:\Users\cklie.ASIDATAMYTE\Desktop\QDA T20.lnk" /A:C /T:"%CKLIE%\%vCur%\Bin\QDA.exe" /P:" user=Admin DB=KlieMainTest" /W:"%CKLIE%\%vCur%\Bin\"
echo R9M18: & "C:\Program Files (x86)\ShortCut\shortcut.exe" /F:"C:\Users\cklie.ASIDATAMYTE\Desktop\QDA M18.lnk" /A:C /T:"%CKLIE%\%vM18%\Bin\QDA.exe" /P:" user=Admin DB=KlieMainTest" /W:"%CKLIE%\%vM18%\Bin\"
echo R9M15: & "C:\Program Files (x86)\ShortCut\shortcut.exe" /F:"C:\Users\cklie.ASIDATAMYTE\Desktop\QDA M15.lnk" /A:C /T:"%CKLIE%\%vM15%\Bin\QDA.exe" /P:" user=Admin DB=KlieMainTest" /W:"%CKLIE%\%vM15%\Bin\"
echo R9M12: & "C:\Program Files (x86)\ShortCut\shortcut.exe" /F:"C:\Users\cklie.ASIDATAMYTE\Desktop\QDA M12.lnk" /A:C /T:"%CKLIE%\%vM12%\Bin\QDA.exe" /P:" user=Admin DB=KlieMainTest" /W:"%CKLIE%\%vM12%\Bin\"



echo Kopiervorgang Upgrader und xml Datei...
attrib -r "%CKLIE%\%vCur%\Data\Upgrade.xml"
echo Upgrader_Debug: & copy "%EXIA%\QDA9.R9T20v0Kandidat\Upgrader_Debug.exe" "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" /y
echo Upgrade.xml: & copy "%EXIA%\QDA9.R9T20v0Kandidat\Upgrade.xml" "%CKLIE%\%vCur%\Data\Upgrade.xml" /y

REM DB Namen, zum Beispiel: [Lizenz] für /DB="Lizenz", müssen in der Alias.ini vorhanden sein.
echo Datenbank Upgrade...
echo.|set /p =Lizenz 			& 	  "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Lizenz" 				& echo DONE
echo.|set /p =Klie MainTest 		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="KlieMainTest" 			& echo DONE
echo.|set /p =Klie Explor 		& 	  "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Klie Explor" 			& echo DONE
echo.|set /p =Current 		& 		  "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Current" 				& echo DONE
echo.|set /p =T19Test 		& 		  "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="T19Test" 				& echo DONE
echo.|set /p =CK_ORCL11_TEST 		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="CK_ORCL11_TEST" 		& echo DONE
echo.|set /p =CK_ORCL12_TEST 		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="CK_ORCL12_TEST" 		& echo DONE
echo.|set /p =Lego GageTool 		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Lego GageTool" 		& echo DONE
echo.|set /p =Hotline_Demo 		& 	  "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Hotline_Demo" 			& echo DONE
echo.|set /p =Ford Testbeispiele 	& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Ford Testbeispiele" 	& echo DONE
echo.|set /p =KLASSENTESTS-MSSQL 	& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="KLASSENTESTS-MSSQL" 	& echo DONE
echo.|set /p =KLASSENTESTS-ORACLE 	& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="KLASSENTESTS-ORACLE" 	& echo DONE
echo.|set /p =Scenario 0  		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Scenario 0 - Default" 				& echo DONE
echo.|set /p =Scenario 1 		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Scenario 1 - MostCommon" 			& echo DONE
echo.|set /p =Scenario 2  		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Scenario 2 - FarAwayFromDefault" 	& echo DONE
echo.|set /p =Scenario 3  		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Scenario 3 - Import DFQ" 			& echo DONE
echo.|set /p =Scenario 4 		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Scenario 4 - Import CSV Header"	& echo DONE
echo.|set /p =Scenario 5 		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Scenario 5 - Import CSV" 			& echo DONE
echo.|set /p =Scenario 6 		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Scenario 6 - FordTestExamples" 	& echo DONE
echo.|set /p =Scenario 7  		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Scenario 7 - FDA Validation" 		& echo DONE
echo.|set /p =Scenario 8  		& "%CKLIE%\%vCur%\Bin\Upgrader_Debug.exe" -SETUP /S /DB="Scenario 8 - Performance" 			& echo DONE

pause
