echo "Please Wait..."
cd $ORACLE_MON
cd ..
rm -f dbmon.tar.gz
tar cf - dbmon/. |gzip >dbmon.tar.gz
rm -f app.tar.gz
tar cf - app/. | gzip >app.tar.gz
rm -f util.tar.gz
tar cf - util/. | gzip > util.tar.gz
rm -f vim.tar.gz
tar cf - vim/. | gzip > vim.tar.gz
