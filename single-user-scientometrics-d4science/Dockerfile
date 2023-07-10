# Scientometrics D4science


ARG BASE_IMAGE=eginotebooks/d4science-base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        nco \
        cdo \
        cmake \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

# -------------------------------
# Scientomatic specific libraries
# -------------------------------

RUN mamba install -y --quiet \
        libmambapy \
        pyspark \
        openjdk=8 \
   && conda clean --all

RUN pip install --no-cache-dir \
        affine==2.4.0 \
        aiofiles \
        aiosqlite \
        alembic \
        altair \
        ansiwrap==0.8.4 \
        anyio \
        argon2-cffi \
        argon2-cffi-bindings \
        asttokens \
        async-generator==1.10 \
        attrs \
        Babel \
        backcall \
        backports.functools-lru-cache \
        beautifulsoup4 \
        bleach \
        blinker \
        bokeh \
        boltons \
        Bottleneck \
        brotlipy \
        cached-property \
        certifi==2023.5.7 \
        certipy==0.1.3 \
        cffi \
        charset-normalizer \
        click \
        click-plugins==1.1.1 \
        cligj==0.7.2 \
        cloudpickle \
        colorama \
        comm \
        contextily==1.3.0 \
        contourpy \
        coverage==7.2.5 \
        cryptography \
        cycler \
        Cython \
        cytoolz \
        dask \
        debugpy \
        decorator \
        defusedxml \
        dill \
        distributed \
        entrypoints \
        et-xmlfile \
        executing \
        fastjsonschema \
        Fiona==1.9.3 \
        flake8==6.0.0 \
        flit_core \
        fonttools \
        fsspec \
        geographiclib==2.0 \
        geopandas==0.13.0 \
        geopy==2.3.0 \
        gitdb \
        GitPython \
        gmpy2 \
        greenlet \
        h5py \
        idna \
        igraph==0.10.4 \
        imagecodecs \
        imageio \
        importlib-metadata \
        importlib-resources \
        ipykernel \
        ipympl \
        ipython \
        ipython-genutils==0.2.0 \
        ipywidgets \
        jedi \
        Jinja2 \
        joblib \
        json5 \
        jsonpatch \
        jsonpointer==2.0 \
        jsonschema \
        kiwisolver \
        lazy_loader \
        locket \
        lz4 \
        Mako \
        mamba \
        MarkupSafe \
        matplotlib \
        matplotlib-inline \
        mccabe==0.7.0 \
        mercantile==1.2.1 \
        mistune \
        mpmath \
        msgpack \
        munch==2.5.0 \
        munkres==1.1.4 \
        nbclassic \
        nbclient \
        nbconvert \
        nbdime \
        nbformat \
        nest-asyncio \
        networkx \
        notebook \
        notebook_shim \
        numba \
        numexpr \
        numpy \
        oauthlib \
        openpyxl \
        packaging \
        pamela==1.0.0 \
        pandas \
        pandocfilters \
        papermill==2.4.0 \
        parso \
        partd \
        patsy \
        pexpect \
        pickleshare \
        Pillow \
        pkgutil_resolve_name \
        platformdirs \
        plotly \
        pluggy \
        pooch \
        prometheus-client \
        prompt-toolkit \
        protobuf==4.21.12 \
        psutil \
        ptyprocess \
        pure-eval \
        py-cpuinfo \
        pyarrow==12.0.0 \
        pycodestyle==2.10.0 \
        pycosat \
        pycparser \
        pyflakes==3.0.1 \
        Pygments \
        PyJWT \
        pyOpenSSL \
        pyparsing \
        pyproj==3.5.0 \
        pyrsistent \
        PySocks \
        python-dateutil \
        python-dotenv==1.0.0 \
        python-json-logger \
        pytz \
        PyWavelets \
        PyYAML \
        pyzmq \
        rasterio==1.3.6 \
        requests \
        rfc3339-validator \
        rfc3986-validator \
        ruamel.yaml \
        ruamel.yaml.clib \
        scikit-image \
        scikit-learn \
        scipy \
        seaborn \
        Send2Trash \
        shapely==2.0.1 \
        six \
        smmap \
        sniffio \
        snuggs==1.4.7 \
        sortedcontainers \
        soupsieve \
        SQLAlchemy \
        git+https://github.com/andremann/SciSci-course.git \
        stack-data \
        statsmodels \
        sympy \
        tables \
        tblib \
        tenacity==8.2.2 \
        terminado \
        texttable==1.6.7 \
        textwrap3==0.9.2 \
        threadpoolctl \
        tifffile \
        tinycss2 \
        tomli \
        toolz \
        tornado \
        tqdm \
        traitlets \
        typing_extensions \
        tzdata \
        unicodedata2 \
        urllib3 \
        wcwidth \
        webencodings==0.5.1 \
        websocket-client \
        widgetsnbextension \
        xlrd \
        xyzservices \
        y-py \
        ypy-websocket \
        zict \
        zipp \
        zstandard==0.19.0

# -------------------------------
# Jupyter lab extensions
# -------------------------------
RUN pip install --no-cache-dir \
    jupyterlab-topbar \
    jupyterlab-system-monitor
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
