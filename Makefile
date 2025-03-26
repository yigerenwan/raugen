package/raugen/build: ## DEV Build
	@cd modules/raugen && rm -rf raugen.egg-info && python3 setup.py sdist bdist_wheel

package/raugen/build_and_install: ## DEV build and install
	@cd modules/raugen && rm -rf raugen.egg-info && python3 setup.py sdist bdist_wheel && pip install -U .

package/raugen/bumpversion: guard-V ## Bump the version the package
	@cd modules/raugen && bump2version $(V)
	@cd modules/raugen && rm -r raugen.egg-info && rm -r dist && python3 setup.py sdist bdist_wheel
	@cd modules/raugen && rm -rf raugen.egg-info && python3 setup.py sdist bdist_wheel && pip install -U .

package/raugen/release: guard-V ## Release the package
	@cd modules/raugen && bump2version $(V) && git push --tags
	@cd modules/raugen && (rm -r raugen.egg-info || true) && (rm -r dist || true) && python3 setup.py sdist bdist_wheel
	@cd modules/raugen/dist && twine upload *.whl

package/raugen/docs: ## Build documentation
	@cd modules/raugen/docs && make clean && (rm -r source || true ) && make clean html
	@cd modules/raugen/docs && sphinx-apidoc --force -o source ../raugen/
	@cd modules/raugen/docs && make html
	@(rm -r /var/www/html/raugen || true) && cd modules/raugen/docs/_build && cp -r html /var/www/html/raugen
